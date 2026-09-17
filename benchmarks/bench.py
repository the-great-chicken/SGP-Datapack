#!/usr/bin/env python3
"""Local SGP datapack benchmark runner.

The runner stages a fresh plugin-free Fabric server, uses PackTest dummies to
create deterministic workloads, starts vanilla /perf, preserves every raw
profile zip, and writes a compact commandFunctions summary.

Requires Python 3.11+ and Java 25. The first run downloads the same pinned
Fabric/PackTest/Bookshelf/Actionbar Mixer dependencies used by CI.
"""
from __future__ import annotations

from collections import defaultdict
from dataclasses import dataclass
from datetime import datetime
from pathlib import Path
from statistics import fmean, median
import argparse
import csv
import hashlib
import importlib.util
import json
import math
import os
import queue
import re
import shutil
import subprocess
import sys
import tempfile
import threading
import time
import urllib.error
import urllib.parse
import urllib.request
import zipfile

ROOT = Path(__file__).resolve().parent.parent
BENCHMARKS = ROOT / 'benchmarks'
DEFAULT_SERVER = ROOT / '.packtest-bench-server'
DEFAULT_CACHE = ROOT / '.bench-cache'
DEFAULT_RESULTS = BENCHMARKS / 'results'
SERVER_MARKER = '.sgp-benchmark-server'
CONFIG = json.loads((BENCHMARKS / 'config.json').read_text(encoding='utf-8'))
PROFILE_LINE = re.compile(
    r'^\[(?P<depth>\d+)]\s*(?:\|\s*)*'
    r'(?P<name>.*)\((?P<count>\d+)/(?P<per_tick>\d+)\)\s+-\s+'
    r'(?P<parent>[0-9.]+)%/(?P<global>[0-9.]+)%$'
)
TIME_SPAN = re.compile(r'^Time span:\s*([0-9.]+)\s*ms$', re.MULTILINE)
TICK_SPAN = re.compile(r'^Tick span:\s*(\d+)\s*ticks$', re.MULTILINE)
VERSION = re.compile(r'^Version:\s*(.+)$', re.MULTILINE)
FUNCTION_CALL = re.compile(r'\bfunction\s+([a-z0-9_.-]+:[a-z0-9_./-]+)')


class BenchmarkError(RuntimeError):
    pass


@dataclass(frozen=True)
class ProfileEntry:
    depth: int
    name: str
    count: int
    per_tick: int
    parent_percent: float
    global_percent: float


@dataclass
class ParsedProfile:
    archive: Path
    time_span_ms: float | None
    tick_span: int | None
    version: str | None
    command_functions_percent: float | None
    entries: list[ProfileEntry]
    tick_times_ms: list[float]

    @property
    def effective_tps(self) -> float | None:
        if not self.time_span_ms or self.tick_span is None:
            return None
        return self.tick_span * 1000.0 / self.time_span_ms

    @property
    def tick_median_ms(self) -> float | None:
        return float(median(self.tick_times_ms)) if self.tick_times_ms else None

    @property
    def tick_mean_ms(self) -> float | None:
        return float(fmean(self.tick_times_ms)) if self.tick_times_ms else None

    @property
    def tick_p95_ms(self) -> float | None:
        return percentile(self.tick_times_ms, 0.95)

    @property
    def tick_p99_ms(self) -> float | None:
        return percentile(self.tick_times_ms, 0.99)

    @property
    def tick_max_ms(self) -> float | None:
        return max(self.tick_times_ms) if self.tick_times_ms else None


@dataclass
class PlanComponent:
    scenario: str
    players: int
    first: int | None
    last: int | None
    parameters: dict[str, int]
    setup: str
    tick: str
    teardown: str

    def as_dict(self) -> dict:
        return {
            'scenario': self.scenario,
            'players': self.players,
            'first': self.first,
            'last': self.last,
            'parameters': self.parameters,
            'setup': self.setup,
            'tick': self.tick,
            'teardown': self.teardown,
        }


def percentile(values: list[float], quantile: float) -> float | None:
    """Nearest-rank percentile, adequate for the ~200 tick samples in /perf."""
    if not values:
        return None
    if not 0.0 <= quantile <= 1.0:
        raise ValueError(f'quantile must be between 0 and 1, got {quantile}')
    ordered = sorted(values)
    rank = max(1, math.ceil(len(ordered) * quantile))
    return float(ordered[min(rank, len(ordered)) - 1])


def load_module(path: Path, name: str):
    spec = importlib.util.spec_from_file_location(name, path)
    if spec is None or spec.loader is None:
        raise BenchmarkError(f'Could not load {path}')
    module = importlib.util.module_from_spec(spec)
    # Some stdlib features (notably dataclasses on newer Python versions) look
    # the module up in sys.modules while its body is executing.
    sys.modules[name] = module
    try:
        spec.loader.exec_module(module)
    except Exception:
        sys.modules.pop(name, None)
        raise
    return module


def load_scenarios() -> dict[str, dict]:
    scenarios: dict[str, dict] = {}
    for path in sorted((BENCHMARKS / 'scenarios').glob('*.json')):
        data = json.loads(path.read_text(encoding='utf-8'))
        name = data.get('name')
        if not isinstance(name, str) or not name:
            raise BenchmarkError(f'{path}: scenario name must be a non-empty string')
        if path.stem != name:
            raise BenchmarkError(f'{path}: filename must match scenario name {name!r}')
        if name in scenarios:
            raise BenchmarkError(f'{path}: duplicate scenario name {name!r}')
        if not isinstance(data.get('description'), str):
            raise BenchmarkError(f'{path}: missing description')
        atomic = all(key in data for key in ('setup', 'tick', 'teardown', 'parameters'))
        composite = 'components' in data
        if atomic == composite:
            raise BenchmarkError(
                f'{path}: scenario must be exactly one of atomic '
                '(setup/tick/teardown/parameters) or composite (components)'
            )
        scenarios[name] = data
    if not scenarios:
        raise BenchmarkError('No benchmark scenarios found')
    validate_scenario_graph(scenarios)
    return scenarios


def validate_parameter_specs(scenario: dict):
    specs = scenario.get('parameters')
    if not isinstance(specs, dict) or 'players' not in specs:
        raise BenchmarkError(f'Scenario {scenario["name"]}: parameters must include players')
    for name, spec in specs.items():
        if not isinstance(spec, dict) or spec.get('type') != 'int':
            raise BenchmarkError(f'Scenario {scenario["name"]}: only int parameters are supported ({name})')
        if not all(key in spec for key in ('min', 'max', 'default')):
            raise BenchmarkError(f'Scenario {scenario["name"]}: incomplete parameter spec for {name}')
        if not all(isinstance(spec[key], int) for key in ('min', 'max', 'default')):
            raise BenchmarkError(f'Scenario {scenario["name"]}: parameter {name} bounds/default must be integers')
        if not spec['min'] <= spec['default'] <= spec['max']:
            raise BenchmarkError(f'Scenario {scenario["name"]}: default for {name} is outside its range')


def validate_scenario_graph(scenarios: dict[str, dict]):
    for scenario in scenarios.values():
        if 'components' not in scenario:
            validate_parameter_specs(scenario)
            continue
        components = scenario['components']
        if not isinstance(components, list) or not components:
            raise BenchmarkError(f'Scenario {scenario["name"]}: components must be a non-empty list')
        for index, component in enumerate(components, 1):
            if not isinstance(component, dict) or not isinstance(component.get('scenario'), str):
                raise BenchmarkError(f'Scenario {scenario["name"]}: component {index} must reference a scenario')
            target = component['scenario']
            if target not in scenarios:
                raise BenchmarkError(f'Scenario {scenario["name"]}: unknown component scenario {target!r}')
            if 'players' in component and (not isinstance(component['players'], int) or component['players'] < 0):
                raise BenchmarkError(f'Scenario {scenario["name"]}: component {index} players must be >= 0')
            overrides = component.get('parameters', {})
            if not isinstance(overrides, dict) or any(not isinstance(value, int) for value in overrides.values()):
                raise BenchmarkError(f'Scenario {scenario["name"]}: component {index} parameters must be integer values')

    def visit(name: str, stack: tuple[str, ...]):
        if name in stack:
            raise BenchmarkError(f'Benchmark scenario composition cycle: {" -> ".join((*stack, name))}')
        scenario = scenarios[name]
        if 'components' not in scenario:
            return
        for component in scenario['components']:
            visit(component['scenario'], (*stack, name))

    for name in scenarios:
        visit(name, ())


def parse_raw_params(raw_params: list[str]) -> dict[str, int]:
    parsed: dict[str, int] = {}
    for item in raw_params:
        if '=' not in item:
            raise BenchmarkError(f'Invalid --param {item!r}; expected NAME=INTEGER')
        name, value = item.split('=', 1)
        try:
            parsed[name] = int(value)
        except ValueError as exc:
            raise BenchmarkError(f'Parameter {name!r} must be an integer') from exc
    return parsed


def parameter_values(scenario: dict, players: int | None = None,
                     overrides: dict[str, int] | None = None) -> dict[str, int]:
    validate_parameter_specs(scenario)
    specs = scenario['parameters']
    values = {name: int(spec['default']) for name, spec in specs.items()}
    if players is not None:
        values['players'] = players
    for name, value in (overrides or {}).items():
        if name == 'players':
            raise BenchmarkError('Set component player counts with "players", not parameters.players')
        if name not in specs:
            raise BenchmarkError(f'Unknown parameter {name!r} for scenario {scenario["name"]}')
        values[name] = value
    for name, spec in specs.items():
        value = values[name]
        if not int(spec['min']) <= value <= int(spec['max']):
            raise BenchmarkError(
                f'{name}={value} is outside {spec["min"]}..{spec["max"]} '
                f'for scenario {scenario["name"]}'
            )
    return values


def validate_parameters(scenario: dict, players: int | None, raw_params: list[str]) -> dict[str, int]:
    if 'components' in scenario:
        if players is not None or raw_params:
            raise BenchmarkError(
                f'Scenario {scenario["name"]} is a composition; configure its component counts/parameters in JSON'
            )
        return {}
    return parameter_values(scenario, players, parse_raw_params(raw_params))


def resolve_plan(scenarios: dict[str, dict], name: str, players: int | None = None,
                 raw_params: list[str] | None = None) -> tuple[dict, dict[str, int], list[PlanComponent]]:
    if name not in scenarios:
        raise BenchmarkError(f'Unknown scenario {name!r}; use `list` to see available scenarios')
    selected = scenarios[name]
    top_params = validate_parameters(selected, players, raw_params or [])
    plan: list[PlanComponent] = []
    cursor = 1

    def add_atomic(scenario: dict, count: int | None, overrides: dict[str, int] | None):
        nonlocal cursor
        values = parameter_values(scenario, count, overrides)
        actor_count = values['players']
        first = cursor if actor_count else None
        last = cursor + actor_count - 1 if actor_count else None
        params = {key: value for key, value in values.items() if key != 'players'}
        plan.append(PlanComponent(
            scenario=scenario['name'], players=actor_count, first=first, last=last,
            parameters=params, setup=scenario['setup'], tick=scenario['tick'], teardown=scenario['teardown'],
        ))
        cursor += actor_count

    def expand(scenario_name: str, component: dict | None = None, stack: tuple[str, ...] = ()):
        scenario = scenarios[scenario_name]
        if scenario_name in stack:
            raise BenchmarkError(f'Benchmark scenario composition cycle: {" -> ".join((*stack, scenario_name))}')
        if 'components' not in scenario:
            add_atomic(
                scenario,
                component.get('players') if component else (top_params.get('players') if scenario_name == name else None),
                component.get('parameters', {}) if component else (
                    {key: value for key, value in top_params.items() if key != 'players'} if scenario_name == name else {}
                ),
            )
            return
        if component and ('players' in component or component.get('parameters')):
            raise BenchmarkError(
                f'Composite scenario {scenario_name!r} cannot be resized/parameterized as a component; '
                'configure its child components instead'
            )
        for child in scenario['components']:
            expand(child['scenario'], child, (*stack, scenario_name))

    expand(name)
    total = sum(component.players for component in plan)
    if total > 40:
        raise BenchmarkError(f'Scenario {name!r} resolves to {total} players; PackTest benchmark pool maximum is 40')
    return selected, top_params, plan


def cached_download(url: str, cache_dir: Path, label: str) -> Path:
    cache_dir.mkdir(parents=True, exist_ok=True)
    url_name = Path(urllib.parse.unquote(urllib.parse.urlparse(url).path)).name or label
    safe_label = label.replace('/', '__')
    url_key = hashlib.sha256(url.encode('utf-8')).hexdigest()[:12]
    target = cache_dir / f'{safe_label}--{url_key}--{url_name}'
    if target.is_file() and target.stat().st_size > 0:
        return target
    print(f'Downloading {label} ...')
    fd, temporary_name = tempfile.mkstemp(prefix=target.name + '.', suffix='.part', dir=cache_dir)
    os.close(fd)
    temporary = Path(temporary_name)
    try:
        with urllib.request.urlopen(url) as response, temporary.open('wb') as output:
            shutil.copyfileobj(response, output)
        if temporary.stat().st_size == 0:
            raise BenchmarkError(f'Downloaded empty file for {label}')
        temporary.replace(target)
    except Exception:
        temporary.unlink(missing_ok=True)
        raise
    return target


def verify_zip(path: Path, label: str):
    try:
        with zipfile.ZipFile(path) as archive:
            bad = archive.testzip()
            if bad:
                raise BenchmarkError(f'{label} is corrupt at {bad}')
    except zipfile.BadZipFile as exc:
        raise BenchmarkError(f'{label} is not a valid jar/zip: {path}') from exc


def prepare_server(server: Path, cache_dir: Path):
    if server.exists():
        if not (server / SERVER_MARKER).is_file():
            raise BenchmarkError(
                f'Refusing to delete existing directory without {SERVER_MARKER}: {server}'
            )
        shutil.rmtree(server)
    prepare_bench = load_module(ROOT / '.github/scripts/prepare_bench.py', 'sgp_prepare_bench_runtime')
    prepare_bench.prepare(ROOT, server)

    downloads: dict[str, Path] = {}
    for destination, url in CONFIG['dependencies'].items():
        archive = cached_download(url, cache_dir, destination)
        verify_zip(archive, destination)
        downloads[destination] = archive
        if destination == 'actionbar-mixer.zip':
            continue
        target = server / destination
        target.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(archive, target)

    mixer = load_module(ROOT / '.github/scripts/install_mixer.py', 'sgp_install_mixer_runtime')
    mixer.install(server, downloads['actionbar-mixer.zip'])
    print(f'Benchmark server ready: {server}')


class ServerProcess:
    def __init__(self, server: Path, java: str, heap: str):
        self.server = server
        self.java = java
        self.heap = heap
        self.process: subprocess.Popen[str] | None = None
        self.lines: list[str] = []
        self._condition = threading.Condition()
        self._reader: threading.Thread | None = None
        self._log = None

    def start(self, timeout: float = 120.0):
        if not (self.server / 'server.jar').is_file():
            raise BenchmarkError(f'Missing {self.server / "server.jar"}; prepare the server first')
        command = [self.java, f'-Xms{self.heap}', f'-Xmx{self.heap}', '-jar', 'server.jar', 'nogui']
        self._log = (self.server / 'benchmark-console.log').open('w', encoding='utf-8')
        try:
            self.process = subprocess.Popen(
                command,
                cwd=self.server,
                stdin=subprocess.PIPE,
                stdout=subprocess.PIPE,
                stderr=subprocess.STDOUT,
                text=True,
                encoding='utf-8',
                errors='replace',
                bufsize=1,
            )
        except FileNotFoundError as exc:
            self._log.close()
            raise BenchmarkError(f'Could not find Java executable {self.java!r}') from exc
        self._reader = threading.Thread(target=self._read_output, name='sgp-bench-server-log', daemon=True)
        self._reader.start()
        try:
            self.wait_for(lambda line: 'Done (' in line and 'For help, type' in line, timeout)
        except Exception:
            self.stop(force=True)
            raise

    def _read_output(self):
        assert self.process is not None and self.process.stdout is not None and self._log is not None
        for line in self.process.stdout:
            self._log.write(line)
            self._log.flush()
            with self._condition:
                self.lines.append(line.rstrip('\n'))
                self._condition.notify_all()
        with self._condition:
            self._condition.notify_all()

    def wait_for(self, predicate, timeout: float, start_at: int = 0) -> str:
        deadline = time.monotonic() + timeout
        index = start_at
        while True:
            with self._condition:
                while index < len(self.lines):
                    line = self.lines[index]
                    index += 1
                    if predicate(line):
                        return line
                if self.process is not None and self.process.poll() is not None:
                    tail = '\n'.join(self.lines[-30:])
                    raise BenchmarkError(f'Minecraft server exited unexpectedly. Last output:\n{tail}')
                remaining = deadline - time.monotonic()
                if remaining <= 0:
                    tail = '\n'.join(self.lines[-30:])
                    raise BenchmarkError(f'Timed out waiting for server output. Last output:\n{tail}')
                self._condition.wait(min(remaining, 0.25))

    def send(self, command: str):
        if self.process is None or self.process.poll() is not None or self.process.stdin is None:
            raise BenchmarkError('Minecraft server is not running')
        self.process.stdin.write(command + '\n')
        self.process.stdin.flush()

    def sleep_alive(self, seconds: float):
        deadline = time.monotonic() + seconds
        while time.monotonic() < deadline:
            if self.process is None or self.process.poll() is not None:
                tail = '\n'.join(self.lines[-30:])
                raise BenchmarkError(f'Minecraft server exited unexpectedly. Last output:\n{tail}')
            time.sleep(min(0.2, deadline - time.monotonic()))

    def score(self, player: str, objective: str = 'sgp.bench', timeout: float = 5.0) -> int | None:
        before = len(self.lines)
        self.send(f'scoreboard players get {player} {objective}')
        pattern = re.compile(rf'{re.escape(player)} has (-?\d+) \[{re.escape(objective)}\]')
        try:
            line = self.wait_for(lambda item: pattern.search(item) is not None, timeout, start_at=before)
        except BenchmarkError:
            return None
        match = pattern.search(line)
        return int(match.group(1)) if match else None

    def require_score(self, player: str, expected: int, objective: str = 'sgp.bench') -> int:
        value = self.score(player, objective)
        if value != expected:
            raise BenchmarkError(
                f'Benchmark state check failed: expected {player} {objective}={expected}, got {value!r}'
            )
        return value

    def stop(self, force: bool = False):
        process = self.process
        if process is None:
            return
        if process.poll() is None and not force:
            try:
                self.send('stop')
                process.wait(timeout=30)
            except Exception:
                force = True
        if process.poll() is None and force:
            process.terminate()
            try:
                process.wait(timeout=10)
            except subprocess.TimeoutExpired:
                process.kill()
                process.wait(timeout=5)
        if self._reader is not None:
            self._reader.join(timeout=2)
        if self._log is not None and not self._log.closed:
            self._log.close()
        self.process = None


def wait_for_new_profile(server: Path, previous: set[Path], process: ServerProcess, timeout: float = 45.0) -> Path:
    directory = server / 'debug/profiling'
    deadline = time.monotonic() + timeout
    last_size: dict[Path, tuple[int, float]] = {}
    while time.monotonic() < deadline:
        if process.process is None or process.process.poll() is not None:
            raise BenchmarkError('Server exited while waiting for /perf output')
        if directory.is_dir():
            for candidate in sorted(directory.glob('*.zip'), key=lambda path: path.stat().st_mtime):
                resolved = candidate.resolve()
                if resolved in previous:
                    continue
                size = candidate.stat().st_size
                old_size, since = last_size.get(resolved, (-1, time.monotonic()))
                if size != old_size:
                    last_size[resolved] = (size, time.monotonic())
                elif size > 0 and time.monotonic() - since >= 0.5:
                    try:
                        with zipfile.ZipFile(candidate) as archive:
                            archive.getinfo('server/profiling.txt')
                        return candidate
                    except (zipfile.BadZipFile, KeyError):
                        pass
        time.sleep(0.2)
    raise BenchmarkError(f'Timed out waiting for /perf zip in {directory}')


def parse_profile(path: Path) -> ParsedProfile:
    with zipfile.ZipFile(path) as archive:
        try:
            text = archive.read('server/profiling.txt').decode('utf-8', errors='replace')
        except KeyError as exc:
            raise BenchmarkError(f'{path}: missing server/profiling.txt') from exc

        tick_times_ms: list[float] = []
        try:
            ticking = archive.read('server/metrics/ticking.csv').decode('utf-8', errors='replace')
        except KeyError:
            ticking = ''
        if ticking:
            rows = csv.reader(ticking.splitlines())
            try:
                header = next(rows)
            except StopIteration:
                header = []
            tick_index = next(
                (index for index, name in enumerate(header) if name.strip().lower().endswith('ticktime')),
                None,
            )
            if tick_index is not None:
                for row in rows:
                    if tick_index >= len(row):
                        continue
                    try:
                        # Minecraft's ticktime metric is emitted in nanoseconds.
                        value = float(row[tick_index]) / 1_000_000.0
                        if math.isfinite(value) and value >= 0:
                            tick_times_ms.append(value)
                    except ValueError:
                        continue

    time_match = TIME_SPAN.search(text)
    tick_match = TICK_SPAN.search(text)
    version_match = VERSION.search(text)
    parsed_lines: list[ProfileEntry] = []
    for line in text.splitlines():
        match = PROFILE_LINE.match(line.strip())
        if not match:
            continue
        parsed_lines.append(ProfileEntry(
            depth=int(match.group('depth')),
            name=match.group('name').strip(),
            count=int(match.group('count')),
            per_tick=int(match.group('per_tick')),
            parent_percent=float(match.group('parent')),
            global_percent=float(match.group('global')),
        ))

    command_root_index = next((i for i, item in enumerate(parsed_lines) if item.name == 'commandFunctions'), None)
    command_percent = None
    entries: list[ProfileEntry] = []
    if command_root_index is not None:
        root = parsed_lines[command_root_index]
        command_percent = root.global_percent
        for item in parsed_lines[command_root_index + 1:]:
            if item.depth <= root.depth:
                break
            entries.append(item)

    return ParsedProfile(
        archive=path,
        time_span_ms=float(time_match.group(1)) if time_match else None,
        tick_span=int(tick_match.group(1)) if tick_match else None,
        version=version_match.group(1).strip() if version_match else None,
        command_functions_percent=command_percent,
        entries=entries,
        tick_times_ms=tick_times_ms,
    )


def logical_commands(path: Path):
    pending = ''
    start_line = 0
    for number, raw in enumerate(path.read_text(encoding='utf-8').splitlines(), 1):
        stripped = raw.strip()
        if not pending and (not stripped or stripped.startswith('#')):
            continue
        if not pending:
            start_line = number
        if stripped.endswith('\\'):
            pending += stripped[:-1].strip() + ' '
            continue
        command = (pending + stripped).strip()
        pending = ''
        if command.startswith('$'):
            command = command[1:]
        if command and '$(' not in command:
            yield start_line, re.sub(r'\s+', ' ', command).strip()
    if pending.strip():
        command = pending.strip()
        if command.startswith('$'):
            command = command[1:]
        if '$(' not in command:
            yield start_line, re.sub(r'\s+', ' ', command).strip()


def benchmark_source_files(suffix: str | None = None):
    """Yield repository files that can actually be present in a benchmark datapack."""
    production = ROOT / 'data'
    for path in production.rglob('*'):
        if not path.is_file() or (suffix is not None and path.suffix != suffix):
            continue
        relative = path.relative_to(production)
        if not relative.parts:
            continue
        namespace = relative.parts[0]
        if namespace.startswith('sgp.integration.'):
            continue
        if len(relative.parts) >= 2 and relative.parts[1] == 'test':
            continue
        yield path
    fixtures = BENCHMARKS / 'fixtures/data'
    for path in fixtures.rglob('*'):
        if path.is_file() and (suffix is None or path.suffix == suffix):
            yield path


def build_source_index() -> tuple[dict[str, list[str]], dict[str, str]]:
    by_command: dict[str, list[str]] = defaultdict(list)
    by_function: dict[str, str] = {}
    for path in sorted(benchmark_source_files('.mcfunction')):
        if path.is_relative_to(ROOT / 'data'):
            relative_data = path.relative_to(ROOT / 'data')
        else:
            relative_data = path.relative_to(BENCHMARKS / 'fixtures/data')
        parts = relative_data.parts
        if len(parts) >= 3 and parts[1] == 'function':
            identifier = f'{parts[0]}:{Path(*parts[2:]).with_suffix("").as_posix()}'
            by_function.setdefault(identifier, path.relative_to(ROOT).as_posix())
        for line_number, command in logical_commands(path):
            by_command[command].append(f'{path.relative_to(ROOT).as_posix()}:{line_number}')
    return by_command, by_function


def source_hint(name: str, command_index: dict[str, list[str]], function_index: dict[str, str]) -> str:
    normalized = re.sub(r'\s+', ' ', name).strip()
    hits = command_index.get(normalized)
    if hits:
        return ', '.join(hits[:2]) + (' …' if len(hits) > 2 else '')
    match = FUNCTION_CALL.search(normalized)
    if match:
        target = function_index.get(match.group(1))
        if target:
            return f'calls {target}'
    if normalized in function_index:
        return function_index[normalized]
    return ''


def profile_to_dict(profile: ParsedProfile, counters: dict[str, int | None]) -> dict:
    return {
        'archive': profile.archive.name,
        'version': profile.version,
        'time_span_ms': profile.time_span_ms,
        'tick_span': profile.tick_span,
        'effective_tps': profile.effective_tps,
        'tick_time_ms': {
            'samples': len(profile.tick_times_ms),
            'mean': profile.tick_mean_ms,
            'median': profile.tick_median_ms,
            'p95': profile.tick_p95_ms,
            'p99': profile.tick_p99_ms,
            'max': profile.tick_max_ms,
        },
        'command_functions_percent': profile.command_functions_percent,
        'harness_counters_after_profile_write': counters,
        'command_function_entries': [
            {
                'depth': item.depth,
                'name': item.name,
                'count': item.count,
                'per_tick': item.per_tick,
                'parent_percent': item.parent_percent,
                'global_percent': item.global_percent,
            }
            for item in profile.entries
        ],
    }


def format_number(value: float | int | None, digits: int = 2) -> str:
    if value is None:
        return 'n/a'
    if isinstance(value, int):
        return str(value)
    return f'{value:.{digits}f}'


def write_summary(result_dir: Path, scenario: dict, params: dict[str, int], warmup: float,
                  profiles: list[ParsedProfile], counters: list[dict[str, int | None]],
                  plan: list[PlanComponent] | None = None):
    command_index, function_index = build_source_index()
    lines = [
        f'# SGP benchmark: `{scenario["name"]}`',
        '',
        scenario['description'],
        '',
        f'- Parameters: `{json.dumps(params, sort_keys=True)}`',
        f'- Total players: {plan_total_players(plan or [])}',
        f'- Runs: {len(profiles)}',
        f'- Warm-up: {warmup:g}s',
        '- Profiler: vanilla dedicated-server `/perf`',
        '',
    ]
    if plan:
        lines += ['## Workload plan', '']
        for component in plan:
            actor_range = 'none' if component.players == 0 else f'{component.first}..{component.last}'
            lines.append(
                f'- `{component.scenario}`: {component.players} players (actors {actor_range}), '
                f'parameters `{json.dumps(component.parameters, sort_keys=True)}`'
            )
        lines += ['', '## Runs',
        '',
        '| Run | Profile ticks | Tick median | Tick p95 | Tick max | commandFunctions | Driver ticks | Driver actions |',
        '| ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: |',
    ]
    for i, (profile, count) in enumerate(zip(profiles, counters), 1):
        lines.append(
            f'| {i} | {format_number(profile.tick_span)} | {format_number(profile.tick_median_ms)} ms | '
            f'{format_number(profile.tick_p95_ms)} ms | {format_number(profile.tick_max_ms)} ms | '
            f'{format_number(profile.command_functions_percent)}% | {format_number(count.get("ticks"))} | '
            f'{format_number(count.get("actions"))} |'
        )

    command_values = [p.command_functions_percent for p in profiles if p.command_functions_percent is not None]
    tps_values = [p.effective_tps for p in profiles if p.effective_tps is not None]
    tick_medians = [p.tick_median_ms for p in profiles if p.tick_median_ms is not None]
    tick_p95s = [p.tick_p95_ms for p in profiles if p.tick_p95_ms is not None]
    tick_maxes = [p.tick_max_ms for p in profiles if p.tick_max_ms is not None]
    if command_values or tps_values or tick_medians or tick_p95s or tick_maxes:
        lines += ['', '## Aggregate', '']
        if tick_medians:
            lines.append(
                f'- Median run tick median: **{median(tick_medians):.3f} ms** '
                f'(range {min(tick_medians):.3f}–{max(tick_medians):.3f} ms).'
            )
        if tick_p95s:
            lines.append(
                f'- Median run tick p95: **{median(tick_p95s):.3f} ms** '
                f'(range {min(tick_p95s):.3f}–{max(tick_p95s):.3f} ms).'
            )
        if tick_maxes:
            lines.append(
                f'- Median run maximum tick: **{median(tick_maxes):.3f} ms** '
                f'(range {min(tick_maxes):.3f}–{max(tick_maxes):.3f} ms).'
            )
        if command_values:
            lines.append(
                f'- Median `commandFunctions`: **{median(command_values):.2f}%** '
                f'(range {min(command_values):.2f}–{max(command_values):.2f}%).'
            )
        if tps_values:
            lines.append(
                f'- Median effective TPS during capture: **{median(tps_values):.2f}** '
                f'(range {min(tps_values):.2f}–{max(tps_values):.2f}).'
            )

    grouped: dict[str, list[ProfileEntry]] = defaultdict(list)
    for profile in profiles:
        # One value per name/run prevents recursive/repeated appearances from overweighting a run.
        best_in_run: dict[str, ProfileEntry] = {}
        for entry in profile.entries:
            if entry.name in {'unspecified', 'minecraft:tick'}:
                continue
            previous = best_in_run.get(entry.name)
            if previous is None or entry.global_percent > previous.global_percent:
                best_in_run[entry.name] = entry
        for name, entry in best_in_run.items():
            grouped[name].append(entry)

    ranked = []
    for name, entries in grouped.items():
        globals_ = [entry.global_percent for entry in entries]
        ranked.append((median(globals_), name, entries))
    ranked.sort(reverse=True)

    lines += [
        '',
        '## Hottest `commandFunctions` entries',
        '',
        'Inclusive profiler entries can overlap (for example a `function ...` call and commands inside it). '
        'Use this as a locator, not as values to add together.',
        '',
        '| Median global % | Seen | Median calls | Entry | Source hint |',
        '| ---: | ---: | ---: | --- | --- |',
    ]
    for value, name, entries in ranked[:20]:
        calls = median([entry.count for entry in entries])
        hint = source_hint(name, command_index, function_index).replace('|', '\\|')
        safe_name = name.replace('|', '\\|').replace('`', '\\`')
        driver = ' **[driver]**' if 'sgp.bench' in name else ''
        lines.append(
            f'| {value:.3f}% | {len(entries)}/{len(profiles)} | {calls:g} | `{safe_name}`{driver} | {hint} |'
        )

    lines += [
        '',
        '> `Driver ticks/actions` are read immediately after Minecraft finishes writing the profile zip, '
        'so they can include a small tail after the exact `/perf` window. The profile tick span and profiler '
        'counts are the authoritative measured-window values.',
        '',
        'Raw `/perf` archives and one parsed JSON file per run are kept next to this summary.',
        '',
    ]
    (result_dir / 'summary.md').write_text('\n'.join(lines), encoding='utf-8')



def source_fingerprint() -> str:
    """Hash source that can affect the staged benchmark, excluding unit tests/integrations."""
    digest = hashlib.sha256()
    files = list(benchmark_source_files())
    files.extend(path for path in (BENCHMARKS / 'scenarios').rglob('*') if path.is_file())
    files.extend([
        ROOT / 'pack.mcmeta',
        BENCHMARKS / 'config.json',
        BENCHMARKS / 'bench.py',
        ROOT / '.github/scripts/prepare_bench.py',
        ROOT / '.github/scripts/prepare_core.py',
        ROOT / '.github/scripts/install_mixer.py',
    ])
    for path in sorted(set(files), key=lambda item: item.relative_to(ROOT).as_posix()):
        relative = path.relative_to(ROOT).as_posix().encode('utf-8')
        digest.update(len(relative).to_bytes(4, 'big'))
        digest.update(relative)
        data = path.read_bytes()
        digest.update(len(data).to_bytes(8, 'big'))
        digest.update(data)
    return digest.hexdigest()

def git_commit() -> str | None:
    try:
        result = subprocess.run(
            ['git', 'rev-parse', 'HEAD'], cwd=ROOT, capture_output=True, text=True, check=True, timeout=5
        )
        return result.stdout.strip() or None
    except Exception:
        return None


def plan_function_call(identifier: str, component: PlanComponent) -> str | None:
    if component.players == 0 or component.first is None or component.last is None:
        return None
    arguments = {
        'first': component.first,
        'last': component.last,
        'players': component.players,
        **component.parameters,
    }
    serialized = ','.join(f'{name}:{value}' for name, value in arguments.items())
    return f'function {identifier} {{{serialized}}}'


def compile_active_plan(server: Path, plan: list[PlanComponent]):
    target = server / 'world/datapacks/SGP-Datapack/data/sgp.bench/function/generated/active'
    target.mkdir(parents=True, exist_ok=True)

    setup = [
        '#> sgp.bench:generated/active/setup',
        '# Generated by benchmarks/bench.py for this invocation.',
        '',
    ]
    tick = [
        '#> sgp.bench:generated/active/tick',
        '# Generated by benchmarks/bench.py for this invocation.',
        '',
    ]
    teardown = [
        '#> sgp.bench:generated/active/teardown',
        '# Generated by benchmarks/bench.py for this invocation.',
        '',
    ]
    for component in plan:
        setup_call = plan_function_call(component.setup, component)
        tick_call = plan_function_call(component.tick, component)
        if setup_call:
            setup.append(setup_call)
        if tick_call:
            tick.append(tick_call)
    setup.append('scoreboard players set #plan_ready sgp.bench 1')
    for component in reversed(plan):
        teardown_call = plan_function_call(component.teardown, component)
        if teardown_call:
            teardown.append(teardown_call)

    for name, lines in (('setup', setup), ('tick', tick), ('teardown', teardown)):
        (target / f'{name}.mcfunction').write_text('\n'.join(lines) + '\n', encoding='utf-8')


def plan_total_players(plan: list[PlanComponent]) -> int:
    return sum(component.players for component in plan)


def copy_if_file(source: Path, destination: Path):
    if source.is_file():
        destination.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(source, destination)


def write_failure_bundle(result_dir: Path, metadata: dict, phase: str, exc: Exception,
                         server_dir: Path, server: ServerProcess | None, plan: list[PlanComponent]):
    tail = server.lines[-120:] if server is not None else []
    failure = {
        'failed_at': datetime.now().astimezone().isoformat(),
        'phase': phase,
        'error_type': type(exc).__name__,
        'error': str(exc),
        'server_dir': str(server_dir),
        'recent_console_lines': tail,
    }
    (result_dir / 'failure.json').write_text(json.dumps(failure, indent=2) + '\n', encoding='utf-8')

    metadata = dict(metadata)
    metadata['status'] = 'failed'
    metadata['failure'] = {'phase': phase, 'error_type': type(exc).__name__, 'error': str(exc)}
    (result_dir / 'metadata.json').write_text(json.dumps(metadata, indent=2) + '\n', encoding='utf-8')

    diagnostics = result_dir / 'diagnostics'
    copy_if_file(server_dir / 'benchmark-console.log', diagnostics / 'benchmark-console.log')
    copy_if_file(server_dir / 'logs/latest.log', diagnostics / 'latest.log')
    copy_if_file(server_dir / 'server.properties', diagnostics / 'server.properties')
    datapack_bench = server_dir / 'world/datapacks/SGP-Datapack/data/sgp.bench/function'
    copy_if_file(datapack_bench / 'fixture/setup.mcfunction', diagnostics / 'fixture-setup.mcfunction')
    copy_if_file(datapack_bench / 'load.mcfunction', diagnostics / 'benchmark-load.mcfunction')
    active = datapack_bench / 'generated/active'
    if active.is_dir():
        target = diagnostics / 'generated-active'
        target.mkdir(parents=True, exist_ok=True)
        for source in active.glob('*.mcfunction'):
            shutil.copy2(source, target / source.name)

    lines = [
        '# Benchmark failed',
        '',
        f'- Phase: `{phase}`',
        f'- Error: `{type(exc).__name__}: {str(exc).replace("`", "\\`")}`',
        f'- Scenario: `{metadata.get("scenario")}`',
        f'- Total players: {plan_total_players(plan)}',
        '',
        'The raw diagnostics are in `failure.json` and `diagnostics/`. In particular, '
        '`diagnostics/benchmark-console.log` preserves the dedicated-server console when available.',
        '',
    ]
    if tail:
        lines += ['## Last server console lines', '', '```text', *tail[-40:], '```', '']
    (result_dir / 'failure.md').write_text('\n'.join(lines), encoding='utf-8')


def mark_success(result_dir: Path, metadata: dict):
    metadata = dict(metadata)
    metadata['status'] = 'complete'
    metadata['completed_at'] = datetime.now().astimezone().isoformat()
    (result_dir / 'metadata.json').write_text(json.dumps(metadata, indent=2) + '\n', encoding='utf-8')


def run_benchmark(args):
    scenarios = load_scenarios()
    scenario, params, plan = resolve_plan(scenarios, args.scenario, args.players, args.param)
    total_players = plan_total_players(plan)
    server_dir = args.server_dir.resolve()
    cache_dir = args.cache_dir.resolve()
    results_root = args.results_dir.resolve()

    timestamp = datetime.now().strftime('%Y-%m-%d_%H.%M.%S.%f')[:-3]
    suffix = f'players-{total_players}'
    result_dir = results_root / f'{timestamp}_{scenario["name"]}_{suffix}'
    result_dir.mkdir(parents=True, exist_ok=False)

    metadata = {
        'created_at': datetime.now().astimezone().isoformat(),
        'status': 'running',
        'scenario': scenario['name'],
        'description': scenario['description'],
        'parameters': params,
        'total_players': total_players,
        'plan': [component.as_dict() for component in plan],
        'runs': args.runs,
        'warmup_seconds': args.warmup,
        'minecraft_version': CONFIG['minecraft_version'],
        'java_expected': CONFIG['java_version'],
        'heap': args.heap,
        'git_commit': git_commit(),
        'source_sha256': source_fingerprint(),
    }
    (result_dir / 'metadata.json').write_text(json.dumps(metadata, indent=2) + '\n', encoding='utf-8')

    server: ServerProcess | None = None
    profiles: list[ParsedProfile] = []
    counters: list[dict[str, int | None]] = []
    phase = 'preparing benchmark server'
    try:
        if not args.reuse_server:
            prepare_server(server_dir, cache_dir)
        elif not (server_dir / SERVER_MARKER).is_file() or not (server_dir / 'server.jar').is_file():
            raise BenchmarkError(f'--reuse-server was requested but {server_dir} is not prepared')

        phase = 'compiling active scenario plan'
        compile_active_plan(server_dir, plan)

        server = ServerProcess(server_dir, args.java, args.heap)
        phase = 'starting Minecraft server'
        print('Starting Minecraft server ...')
        server.start(timeout=args.startup_timeout)

        phase = 'creating benchmark fixture'
        print('Server ready; creating benchmark fixture.')
        server.send('function sgp.bench:fixture/setup')
        server.require_score('#fixture_ready', 1)

        for run_number in range(1, args.runs + 1):
            phase = f'run {run_number}/{args.runs} setup'
            print(f'Run {run_number}/{args.runs}: setup')
            server.send(f'function sgp.bench:prepare {{players:{total_players}}}')
            server.send('function sgp.bench:generated/active/setup')
            server.send('function sgp.bench:start')
            server.send('execute store result score #actual_players sgp.bench if entity @a[tag=sgp.bench.actor]')
            server.require_score('#players', total_players)
            server.require_score('#actual_players', total_players)
            server.require_score('#plan_ready', 1)
            server.require_score('#enabled', 1)

            phase = f'run {run_number}/{args.runs} warm-up'
            server.sleep_alive(args.warmup)

            phase = f'run {run_number}/{args.runs} profiling'
            server.send('function sgp.bench:measurement_reset')
            profile_dir = server_dir / 'debug/profiling'
            previous = {path.resolve() for path in profile_dir.glob('*.zip')} if profile_dir.is_dir() else set()
            print(f'Run {run_number}/{args.runs}: /perf')
            server.send('perf start')
            profile_path = wait_for_new_profile(server_dir, previous, server, timeout=args.profile_timeout)
            server.send('scoreboard players set #enabled sgp.bench 0')
            count = {
                'ticks': server.score('#ticks'),
                'actions': server.score('#actions'),
            }
            counters.append(count)

            phase = f'run {run_number}/{args.runs} parsing profile'
            destination = result_dir / f'run-{run_number:02d}.zip'
            shutil.copy2(profile_path, destination)
            parsed = parse_profile(destination)
            profiles.append(parsed)
            (result_dir / f'run-{run_number:02d}.json').write_text(
                json.dumps(profile_to_dict(parsed, count), indent=2) + '\n', encoding='utf-8'
            )
            print(
                f'Run {run_number}/{args.runs}: captured {parsed.tick_span or "?"} ticks, '
                f'tick median={format_number(parsed.tick_median_ms, 3)} ms, '
                f'p95={format_number(parsed.tick_p95_ms, 3)} ms, '
                f'commandFunctions={format_number(parsed.command_functions_percent)}%'
            )

            phase = f'run {run_number}/{args.runs} teardown'
            server.send('function sgp.bench:reset')
            server.sleep_alive(0.5)

        if not profiles:
            raise BenchmarkError('No profiles were captured')
        phase = 'writing summary'
        write_summary(result_dir, scenario, params, args.warmup, profiles, counters, plan=plan)
        mark_success(result_dir, metadata)
    except Exception as exc:
        stop_error = None
        if server is not None:
            try:
                server.stop()
            except Exception as stop_exc:  # Diagnostics should survive teardown failures too.
                stop_error = stop_exc
        write_failure_bundle(result_dir, metadata, phase, exc, server_dir, server, plan)
        if stop_error is not None:
            (result_dir / 'diagnostics/server-stop-error.txt').write_text(
                f'{type(stop_error).__name__}: {stop_error}\n', encoding='utf-8'
            )
        print(f'Failure diagnostics: {result_dir}', file=sys.stderr)
        raise
    else:
        if server is not None:
            server.stop()

    print(f'\nResults: {result_dir}')
    print(f'Summary: {result_dir / "summary.md"}')

def parse_archives(args):
    command_index, function_index = build_source_index()
    for path in args.archives:
        profile = parse_profile(path.resolve())
        print(f'\n{path}')
        print(f'  ticks: {format_number(profile.tick_span)}')
        print(f'  effective TPS: {format_number(profile.effective_tps)}')
        print(
            '  tick time: '
            f'median={format_number(profile.tick_median_ms, 3)} ms, '
            f'p95={format_number(profile.tick_p95_ms, 3)} ms, '
            f'p99={format_number(profile.tick_p99_ms, 3)} ms, '
            f'max={format_number(profile.tick_max_ms, 3)} ms '
            f'({len(profile.tick_times_ms)} samples)'
        )
        print(f'  commandFunctions: {format_number(profile.command_functions_percent)}%')
        entries = [entry for entry in profile.entries if entry.name not in {'unspecified', 'minecraft:tick'}]
        entries.sort(key=lambda item: item.global_percent, reverse=True)
        for entry in entries[:args.top]:
            hint = source_hint(entry.name, command_index, function_index)
            suffix = f'  <- {hint}' if hint else ''
            print(f'  {entry.global_percent:7.3f}%  {entry.count:7d}x  {entry.name}{suffix}')



def load_result_directory(path: Path) -> tuple[dict, list[dict]]:
    path = path.resolve()
    metadata_path = path / 'metadata.json'
    if not metadata_path.is_file():
        raise BenchmarkError(f'{path}: missing metadata.json')
    metadata = json.loads(metadata_path.read_text(encoding='utf-8'))
    runs = []
    for run_path in sorted(path.glob('run-*.json')):
        runs.append(json.loads(run_path.read_text(encoding='utf-8')))
    if not runs:
        raise BenchmarkError(f'{path}: no run-*.json files found')
    return metadata, runs


def numeric_median(runs: list[dict], key: str) -> float | None:
    values = [run.get(key) for run in runs if isinstance(run.get(key), (int, float))]
    return float(median(values)) if values else None


def nested_numeric_median(runs: list[dict], outer: str, inner: str) -> float | None:
    values = []
    for run in runs:
        container = run.get(outer)
        if not isinstance(container, dict):
            continue
        value = container.get(inner)
        if isinstance(value, (int, float)):
            values.append(value)
    return float(median(values)) if values else None


def counter_median(runs: list[dict], key: str) -> float | None:
    values = []
    for run in runs:
        value = run.get('harness_counters_after_profile_write', {}).get(key)
        if isinstance(value, (int, float)):
            values.append(value)
    return float(median(values)) if values else None


def entry_medians(runs: list[dict]) -> dict[str, tuple[float, int, float]]:
    """Return name -> (median global %, runs seen, median count).

    Multiple appearances of one profiler entry in a run are reduced to the
    highest global percentage, matching summary.md.
    """
    per_name: dict[str, list[tuple[float, int]]] = defaultdict(list)
    for run in runs:
        best: dict[str, tuple[float, int]] = {}
        for entry in run.get('command_function_entries', []):
            name = entry.get('name')
            value = entry.get('global_percent')
            count = entry.get('count')
            if not isinstance(name, str) or not isinstance(value, (int, float)) or not isinstance(count, int):
                continue
            previous = best.get(name)
            if previous is None or value > previous[0]:
                best[name] = (float(value), count)
        for name, item in best.items():
            per_name[name].append(item)
    return {
        name: (float(median([v for v, _ in values])), len(values), float(median([c for _, c in values])))
        for name, values in per_name.items()
    }


def relative_change(before: float | None, after: float | None) -> str:
    if before is None or after is None or before == 0:
        return 'n/a'
    return f'{((after - before) / before) * 100:+.1f}%'


def compare_results(args):
    before_meta, before_runs = load_result_directory(args.before)
    after_meta, after_runs = load_result_directory(args.after)
    before_identity = (before_meta.get('scenario'), before_meta.get('parameters'), before_meta.get('plan'))
    after_identity = (after_meta.get('scenario'), after_meta.get('parameters'), after_meta.get('plan'))
    if before_identity != after_identity and not args.allow_mismatch:
        raise BenchmarkError(
            'Benchmark scenario/parameters do not match. Use --allow-mismatch only when that is intentional.\n'
            f'Before: {before_identity}\nAfter:  {after_identity}'
        )

    before_cf = numeric_median(before_runs, 'command_functions_percent')
    after_cf = numeric_median(after_runs, 'command_functions_percent')
    before_tick_median = nested_numeric_median(before_runs, 'tick_time_ms', 'median')
    after_tick_median = nested_numeric_median(after_runs, 'tick_time_ms', 'median')
    before_tick_p95 = nested_numeric_median(before_runs, 'tick_time_ms', 'p95')
    after_tick_p95 = nested_numeric_median(after_runs, 'tick_time_ms', 'p95')
    before_tick_max = nested_numeric_median(before_runs, 'tick_time_ms', 'max')
    after_tick_max = nested_numeric_median(after_runs, 'tick_time_ms', 'max')
    before_tps = numeric_median(before_runs, 'effective_tps')
    after_tps = numeric_median(after_runs, 'effective_tps')
    before_ticks = numeric_median(before_runs, 'tick_span')
    after_ticks = numeric_median(after_runs, 'tick_span')
    before_actions = counter_median(before_runs, 'actions')
    after_actions = counter_median(after_runs, 'actions')

    lines = [
        '# SGP benchmark comparison',
        '',
        f'- Before: `{args.before.resolve()}`',
        f'- After: `{args.after.resolve()}`',
        f'- Scenario before/after: `{before_meta.get("scenario")}` / `{after_meta.get("scenario")}`',
        f'- Parameters before: `{json.dumps(before_meta.get("parameters"), sort_keys=True)}`',
        f'- Parameters after: `{json.dumps(after_meta.get("parameters"), sort_keys=True)}`',
        f'- Runs before/after: {len(before_runs)} / {len(after_runs)}',
        '',
        '## Aggregate',
        '',
        '| Metric | Before median | After median | Change |',
        '| --- | ---: | ---: | ---: |',
    ]
    lines.append(
        f'| Tick median | {format_number(before_tick_median, 3)} ms | {format_number(after_tick_median, 3)} ms | '
        f'{relative_change(before_tick_median, after_tick_median)} |'
    )
    lines.append(
        f'| Tick p95 | {format_number(before_tick_p95, 3)} ms | {format_number(after_tick_p95, 3)} ms | '
        f'{relative_change(before_tick_p95, after_tick_p95)} |'
    )
    lines.append(
        f'| Tick max | {format_number(before_tick_max, 3)} ms | {format_number(after_tick_max, 3)} ms | '
        f'{relative_change(before_tick_max, after_tick_max)} |'
    )
    cf_delta = None if before_cf is None or after_cf is None else after_cf - before_cf
    lines.append(
        f'| `commandFunctions` global % | {format_number(before_cf)}% | {format_number(after_cf)}% | '
        f'{format_number(cf_delta, 3)} pp ({relative_change(before_cf, after_cf)}) |'
    )
    lines.append(
        f'| Effective TPS | {format_number(before_tps)} | {format_number(after_tps)} | '
        f'{relative_change(before_tps, after_tps)} |'
    )
    lines.append(
        f'| Profile ticks | {format_number(before_ticks)} | {format_number(after_ticks)} | '
        f'{relative_change(before_ticks, after_ticks)} |'
    )
    lines.append(
        f'| Driver actions | {format_number(before_actions)} | {format_number(after_actions)} | '
        f'{relative_change(before_actions, after_actions)} |'
    )

    before_entries = entry_medians(before_runs)
    after_entries = entry_medians(after_runs)
    command_index, function_index = build_source_index()
    changes = []
    for name in set(before_entries) | set(after_entries):
        b_value, b_seen, b_count = before_entries.get(name, (0.0, 0, 0.0))
        a_value, a_seen, a_count = after_entries.get(name, (0.0, 0, 0.0))
        changes.append((abs(a_value - b_value), a_value - b_value, name, b_value, a_value,
                        b_seen, a_seen, b_count, a_count))
    changes.sort(reverse=True)

    lines += [
        '',
        '## Largest profiler-entry changes',
        '',
        'These are inclusive `/perf` percentages and can overlap. A missing entry is shown as 0 for ranking; '
        'use the raw profiles when investigating a change.',
        '',
        '| Δ global pp | Before | After | Seen B/A | Median calls B/A | Entry | Source hint |',
        '| ---: | ---: | ---: | ---: | ---: | --- | --- |',
    ]
    emitted = 0
    for _absolute, delta, name, b_value, a_value, b_seen, a_seen, b_count, a_count in changes:
        if emitted >= args.top:
            break
        if max(b_value, a_value) < 0.001 and abs(delta) < 0.001:
            continue
        hint = source_hint(name, command_index, function_index).replace('|', '\\|')
        safe_name = name.replace('|', '\\|').replace('`', '\\`')
        driver = ' **[driver]**' if 'sgp.bench' in name else ''
        lines.append(
            f'| {delta:+.3f} | {b_value:.3f}% | {a_value:.3f}% | '
            f'{b_seen}/{a_seen} | {b_count:g}/{a_count:g} | `{safe_name}`{driver} | {hint} |'
        )
        emitted += 1

    lines += [
        '',
        '> Treat small percentage changes as noise until they repeat across runs. Also check that profile ticks '
        'and driver action counts are comparable before attributing a difference to a datapack change.',
        '',
    ]
    text = '\n'.join(lines)
    if args.output:
        output = args.output.resolve()
        output.parent.mkdir(parents=True, exist_ok=True)
        output.write_text(text, encoding='utf-8')
        print(output)
    else:
        print(text)

def list_scenarios(_args):
    scenarios = load_scenarios()
    for scenario in scenarios.values():
        print(f'{scenario["name"]}: {scenario["description"]}')
        if 'components' in scenario:
            print('  composition:')
            for component in scenario['components']:
                extras = []
                if 'players' in component:
                    extras.append(f'players={component["players"]}')
                if component.get('parameters'):
                    extras.extend(f'{key}={value}' for key, value in component['parameters'].items())
                suffix = f' ({", ".join(extras)})' if extras else ''
                print(f'    - {component["scenario"]}{suffix}')
        else:
            params = ', '.join(
                f'{name}={spec["default"]} ({spec["min"]}..{spec["max"]})'
                for name, spec in scenario['parameters'].items()
            )
            print(f'  parameters: {params}')


def prepare_command(args):
    prepare_server(args.server_dir.resolve(), args.cache_dir.resolve())


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description=__doc__)
    subparsers = parser.add_subparsers(dest='command', required=True)

    list_parser = subparsers.add_parser('list', help='List available benchmark scenarios')
    list_parser.set_defaults(func=list_scenarios)

    prepare_parser = subparsers.add_parser('prepare', help='Prepare/download the local benchmark server only')
    prepare_parser.add_argument('--server-dir', type=Path, default=DEFAULT_SERVER)
    prepare_parser.add_argument('--cache-dir', type=Path, default=DEFAULT_CACHE)
    prepare_parser.set_defaults(func=prepare_command)

    run_parser = subparsers.add_parser('run', help='Run one scenario and collect /perf profiles')
    run_parser.add_argument('scenario')
    run_parser.add_argument('--players', type=int, help='Override an atomic scenario player count')
    run_parser.add_argument('--param', action='append', default=[], metavar='NAME=INT', help='Override an atomic scenario parameter')
    run_parser.add_argument('--runs', type=int, default=5)
    run_parser.add_argument('--warmup', type=float, default=5.0, help='Seconds of active workload before each /perf capture')
    run_parser.add_argument('--java', default='java')
    run_parser.add_argument('--heap', default=CONFIG['heap'])
    run_parser.add_argument('--server-dir', type=Path, default=DEFAULT_SERVER)
    run_parser.add_argument('--cache-dir', type=Path, default=DEFAULT_CACHE)
    run_parser.add_argument('--results-dir', type=Path, default=DEFAULT_RESULTS)
    run_parser.add_argument('--reuse-server', action='store_true', help='Do not rebuild the staged server/world before this invocation')
    run_parser.add_argument('--startup-timeout', type=float, default=120.0)
    run_parser.add_argument('--profile-timeout', type=float, default=45.0)
    run_parser.set_defaults(func=run_benchmark)

    parse_parser = subparsers.add_parser('parse', help='Summarize one or more existing /perf zip files')
    parse_parser.add_argument('archives', nargs='+', type=Path)
    parse_parser.add_argument('--top', type=int, default=20)
    parse_parser.set_defaults(func=parse_archives)

    compare_parser = subparsers.add_parser('compare', help='Compare two benchmark result directories')
    compare_parser.add_argument('before', type=Path)
    compare_parser.add_argument('after', type=Path)
    compare_parser.add_argument('--top', type=int, default=20)
    compare_parser.add_argument('--allow-mismatch', action='store_true', help='Allow different scenario/parameter sets')
    compare_parser.add_argument('--output', type=Path, help='Write Markdown comparison to this path instead of stdout')
    compare_parser.set_defaults(func=compare_results)
    return parser


def main(argv: list[str] | None = None) -> int:
    parser = build_parser()
    args = parser.parse_args(argv)
    if getattr(args, 'runs', 1) < 1:
        parser.error('--runs must be at least 1')
    if getattr(args, 'warmup', 0) < 0:
        parser.error('--warmup cannot be negative')
    try:
        args.func(args)
    except (BenchmarkError, ValueError, OSError, urllib.error.URLError) as exc:
        print(f'benchmark error: {exc}', file=sys.stderr)
        return 2
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
