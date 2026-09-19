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
import io
import importlib.util
import itertools
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

import scenario_validation

ROOT = Path(__file__).resolve().parent.parent
BENCHMARKS = ROOT / 'benchmarks'
DEFAULT_SERVER = ROOT / '.packtest-bench-server'
DEFAULT_CACHE = ROOT / '.bench-cache'
DEFAULT_RESULTS = BENCHMARKS / 'results'
SERVER_MARKER = '.sgp-benchmark-server'
INVALID_MARKER = '.sgp-benchmark-invalid'
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


class BenchmarkInvalidError(BenchmarkError):
    """The workload was interrupted or did not execute as requested."""


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
    counters: dict[str, str]

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
            'counters': self.counters,
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
    scenarios = scenario_validation.load_scenarios(
        BENCHMARKS / 'scenarios', error_type=BenchmarkError
    )
    validate_scenario_graph(scenarios)
    return scenarios


def parameter_default(name: str, spec: dict) -> int:
    return scenario_validation.parameter_default(
        name, spec, int(CONFIG['default_players']), error_type=BenchmarkError
    )


def validate_parameter_specs(scenario: dict):
    scenario_validation.validate_parameter_specs(
        scenario, int(CONFIG['default_players']), error_type=BenchmarkError
    )


def validate_scenario_graph(scenarios: dict[str, dict]):
    scenario_validation.validate_scenario_graph(
        scenarios, int(CONFIG['default_players']), error_type=BenchmarkError
    )



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
    values = {name: parameter_default(name, spec) for name, spec in specs.items()}
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
        minimum = int(spec['min'])
        maximum = int(spec['max']) if 'max' in spec else None
        if value < minimum or (maximum is not None and value > maximum):
            upper = str(maximum) if maximum is not None else 'unbounded'
            raise BenchmarkError(
                f'{name}={value} is outside {minimum}..{upper} for scenario {scenario["name"]}'
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
            counters=dict(scenario.get('counters', {})),
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
        self._health_index = 0
        self._invalid_line: str | None = None

    def check_health(self):
        with self._condition:
            while self._health_index < len(self.lines):
                line = self.lines[self._health_index]
                self._health_index += 1
                if (
                    'Command execution stopped due to limit' in line
                    or 'Failed to load function ' in line
                    or 'Failed to load function tag ' in line
                ):
                    self._invalid_line = self._invalid_line or line
            if self._invalid_line is not None:
                raise BenchmarkInvalidError(
                    f'Minecraft reported an invalid benchmark state: {self._invalid_line}\n'
                    'This invocation is invalid. Fix the load error, or if the command sequence limit was hit, '
                    'start a fresh benchmark with fewer players or an explicit --command-limit. '
                    'Do not reuse the invalid world.'
                )

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
                self.check_health()
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
        self.check_health()
        while time.monotonic() < deadline:
            self.check_health()
            if self.process is None or self.process.poll() is not None:
                tail = '\n'.join(self.lines[-30:])
                raise BenchmarkError(f'Minecraft server exited unexpectedly. Last output:\n{tail}')
            time.sleep(min(0.2, deadline - time.monotonic()))
        self.check_health()

    def score(self, player: str, objective: str = 'sgp.bench', timeout: float = 5.0) -> int | None:
        before = len(self.lines)
        self.send(f'scoreboard players get {player} {objective}')
        pattern = re.compile(rf'{re.escape(player)} has (-?\d+) \[{re.escape(objective)}\]')
        try:
            line = self.wait_for(lambda item: pattern.search(item) is not None, timeout, start_at=before)
        except BenchmarkInvalidError:
            raise
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


def wait_for_new_profile(server: Path, previous: set[Path], process: ServerProcess, timeout: float = 45.0,
                         destination: Path | None = None) -> Path:
    directory = server / 'debug/profiling'
    deadline = time.monotonic() + timeout
    last_size: dict[Path, tuple[int, float]] = {}
    while time.monotonic() < deadline:
        process.check_health()
        if directory.is_dir():
            candidates = []
            for candidate in directory.glob('*.zip'):
                try:
                    candidates.append((candidate.stat().st_mtime, candidate))
                except FileNotFoundError:
                    # Windows can expose the profiler archive while Minecraft is
                    # still finalizing/renaming it. Retry rather than returning a
                    # path which may vanish before the caller can preserve it.
                    continue
            for _mtime, candidate in sorted(candidates):
                try:
                    resolved = candidate.resolve()
                    if resolved in previous:
                        continue
                    size = candidate.stat().st_size
                except FileNotFoundError:
                    continue
                old_size, since = last_size.get(resolved, (-1, time.monotonic()))
                if size != old_size:
                    last_size[resolved] = (size, time.monotonic())
                elif size > 0 and time.monotonic() - since >= 0.5:
                    try:
                        # Read and validate one immutable snapshot. This closes the
                        # race where the source path disappeared after validation
                        # but before shutil.copy2() on Windows.
                        data = candidate.read_bytes()
                        with zipfile.ZipFile(io.BytesIO(data)) as archive:
                            archive.getinfo('server/profiling.txt')
                        process.check_health()
                        if destination is not None:
                            destination.parent.mkdir(parents=True, exist_ok=True)
                            destination.write_bytes(data)
                            return destination
                        return candidate
                    except (FileNotFoundError, PermissionError, zipfile.BadZipFile, KeyError, OSError):
                        pass
        if process.process is None or process.process.poll() is not None:
            raise BenchmarkError('Server exited while waiting for /perf output')
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


def profile_to_dict(profile: ParsedProfile, counters: dict) -> dict:
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


def ray_player_count(plan: list[dict]) -> int:
    return sum(component['players'] for component in plan
               if component['scenario'] in {'ability_rays', 'ability_rays_dense'})


def validate_ray_workload(run: dict, plan: list[dict]) -> dict:
    players = ray_player_count(plan)
    if not players:
        return {}
    ticks = run.get('tick_span')
    if not isinstance(ticks, int) or ticks <= 0:
        raise BenchmarkInvalidError('Cannot validate rays without a positive profile tick count')
    entries = run.get('command_function_entries', [])
    player_ticks = sum(entry['count'] for entry in entries
                       if entry['name'] == 'execute tag @s remove sgp.radiator')
    started = sum(entry['count'] for entry in entries
                  if entry['name'] == 'execute scoreboard players set #ray_dist sgp.dummy 16000')
    completed = sum(entry['count'] for entry in entries if entry['name'].startswith(
        'execute execute store result entity @s transformation.left_rotation[3] '))
    expected_players = players * ticks
    expected_beams = expected_players * 8
    if (player_ticks, started, completed) != (expected_players, expected_beams, expected_beams):
        raise BenchmarkInvalidError(
            f'Incomplete rays workload over {ticks} ticks: completed caster ticks {player_ticks}/{expected_players}, '
            f'started beams {started}/{expected_beams}, completed beams {completed}/{expected_beams}. '
            'Driver exposure counters do not prove that abilities completed.'
        )
    return {'ray_player_ticks': player_ticks, 'ray_beam_updates': completed}


def require_ray_entities(server: ServerProcess, plan: list[dict], *, after_reset: bool = False):
    players = ray_player_count(plan)
    if players:
        server.send('execute store result score #actual_rays sgp.bench if entity @e[tag=sgp.ray,type=item_display]')
        expected = 0 if after_reset else players * 8
        actual = server.score('#actual_rays')
        if actual != expected:
            raise BenchmarkInvalidError(f'Invalid rays entity count: expected {expected}, got {actual!r}')


def validate_diorama_workload(run: dict, plan: list[dict]) -> dict:
    players = sum(component['players'] for component in plan if component['scenario'] == 'diorama_giant')
    if not players:
        return {}
    ticks = run.get('tick_span')
    if not isinstance(ticks, int) or ticks <= 0:
        raise BenchmarkInvalidError('Cannot validate Diorama without a positive profile tick count')
    updates = sum(
        entry['count'] for entry in run.get('command_function_entries', [])
        if 'function sgp.diorama:tick/update_mannequin/apply_mannequin_pos' in entry.get('name', '')
    )
    expected = players * ticks
    if updates != expected:
        raise BenchmarkInvalidError(
            f'Incomplete Diorama workload over {ticks} ticks: mannequin updates {updates}/{expected}'
        )
    return {'diorama_mannequin_updates': updates}


def require_diorama_entities(server: ServerProcess, plan: list[dict], *, after_reset: bool = False):
    components = [component for component in plan if component['scenario'] == 'diorama_giant']
    if not components:
        return
    expected = 0 if after_reset else sum(component['players'] for component in components)
    server.send('execute positioned 0 121 0 store result score #actual_mannequins sgp.bench '
                'if entity @e[tag=sgp.giant_mannequin_99001,distance=..256,type=mannequin]')
    actual = server.score('#actual_mannequins')
    if actual != expected:
        raise BenchmarkInvalidError(f'Invalid Diorama mannequin count: expected {expected}, got {actual!r}')
    if after_reset:
        return
    server.send('scoreboard players set #diorama_valid_owners sgp.bench 0')
    for component in components:
        server.send(f'execute as @a[tag=sgp.bench.actor,scores={{sgp.bench={component["first"]}..{component["last"]}}}] '
                    'run function sgp.bench:scenarios/systems/diorama_giant/verify_owner')
    owners = server.score('#diorama_valid_owners')
    if owners != expected:
        raise BenchmarkInvalidError(f'Invalid Diorama ownership: {owners!r}/{expected} players own exactly one mannequin')


def write_summary(result_dir: Path, scenario: dict, params: dict[str, int], warmup: float,
                  profiles: list[ParsedProfile], counters: list[dict],
                  plan: list[PlanComponent] | None = None, command_limit: int = 65536):
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
        f'- Command sequence limit: {command_limit}',
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
        '| Run | Profile ticks | Tick median | Tick p95 | Tick max | commandFunctions | Driver ticks |',
        '| ---: | ---: | ---: | ---: | ---: | ---: | ---: |',
    ]
    for i, (profile, count) in enumerate(zip(profiles, counters), 1):
        lines.append(
            f'| {i} | {format_number(profile.tick_span)} | {format_number(profile.tick_median_ms)} ms | '
            f'{format_number(profile.tick_p95_ms)} ms | {format_number(profile.tick_max_ms)} ms | '
            f'{format_number(profile.command_functions_percent)}% | {format_number(count.get("ticks"))} |'
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

    workload_names = sorted({
        name
        for count in counters
        for name in (count.get('workload') or {})
    })
    if workload_names:
        lines += ['', '## Workload counters', '', '| Counter | Median | Range |', '| --- | ---: | ---: |']
        for name in workload_names:
            values = [
                count.get('workload', {}).get(name)
                for count in counters
                if isinstance(count.get('workload', {}).get(name), (int, float))
            ]
            if values:
                lines.append(f'| `{name}` | {median(values):g} | {min(values):g}–{max(values):g} |')
            else:
                lines.append(f'| `{name}` | n/a | n/a |')

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
        '> Driver/workload counters are read immediately after Minecraft finishes writing the profile zip, '
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
    files.extend(path for path in (BENCHMARKS / 'suites').rglob('*') if path.is_file())
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


def actor_name(index: int) -> str:
    return f'Bench{index:02d}'


def actor_position(index: int) -> tuple[float, float, float]:
    # Preserve the original 8-column layout while allowing as many rows as the
    # selected workload requires. Individual scenarios may reposition actors.
    zero_based = index - 1
    return (-23.5 + (zero_based % 8) * 7.0, 81.0, -13.5 + (zero_based // 8) * 7.0)


def set_server_property(path: Path, key: str, value: str):
    lines = path.read_text(encoding='utf-8').splitlines() if path.is_file() else []
    prefix = key + '='
    replaced = False
    output = []
    for line in lines:
        if line.startswith(prefix):
            if not replaced:
                output.append(prefix + value)
                replaced = True
        else:
            output.append(line)
    if not replaced:
        output.append(prefix + value)
    path.write_text('\n'.join(output) + '\n', encoding='utf-8')


def previous_actor_count(server: Path) -> int:
    marker = server / '.sgp-benchmark-actor-count'
    if not marker.is_file():
        return 0
    try:
        return max(0, int(marker.read_text(encoding='utf-8').strip()))
    except ValueError:
        return 0


def compile_actor_pool(server: Path, players: int):
    if players < 0:
        raise BenchmarkError(f'Actor count must be non-negative, got {players}')

    target = server / 'world/datapacks/SGP-Datapack/data/sgp.bench/function/actors'
    target.mkdir(parents=True, exist_ok=True)
    cleanup_players = max(players, previous_actor_count(server))

    spawn = [
        '#> sgp.bench:actors/spawn',
        f'# Generated by benchmarks/bench.py for {players} actors.',
        '',
    ]
    cleanup = [
        '#> sgp.bench:actors/cleanup',
        f'# Generated by benchmarks/bench.py for {players} actors.',
        '',
        'execute as @a[tag=sgp.bench.actor,scores={dah.actbar.UID=1..}] run function sgp.bench:actors/remove_mixer_registration',
        '',
    ]

    for index in range(1, players + 1):
        name = actor_name(index)
        x, y, z = actor_position(index)
        spawn += [
            f'dummy {name} spawn',
            f'execute if entity @a[name={name}] run tag {name} add sgp.bench.actor',
            f'execute if entity @a[name={name}] run scoreboard players set {name} sgp.bench {index}',
            f'execute if entity @a[name={name}] run scoreboard players set {name} sgp.id {index}',
            f'execute if entity @a[name={name}] run tp {name} {x:g} {y:g} {z:g} 0 0',
        ]

    for index in range(1, cleanup_players + 1):
        name = actor_name(index)
        cleanup.append(f'execute if entity @a[name={name}] run dummy {name} leave')

    spawn += [
        '',
        'gamemode survival @a[tag=sgp.bench.actor]',
        'clear @a[tag=sgp.bench.actor]',
        'effect clear @a[tag=sgp.bench.actor]',
        'tag @a[tag=sgp.bench.actor] add sgp.in_game',
        'execute as @a[tag=sgp.bench.actor] run function sgp.misc:scoreboards/player_initialization',
    ]

    if cleanup_players:
        cleanup += ['', '# Clear scoreboard state that survives fake-player disconnects.']
        cleanup += [f'scoreboard players reset {actor_name(index)}' for index in range(1, cleanup_players + 1)]
        cleanup += ['', '# Clear benchmark-player rows from persistent production statistics.']
        for index in range(1, cleanup_players + 1):
            cleanup += [
                f'data remove storage sgp.kits:stats players.{index}',
                f'data remove storage sgp.kits:stats kits_dict.{index}',
                f'data remove storage sgp.kits:stats elo_ratings.{index}',
            ]

    (target / 'spawn.mcfunction').write_text('\n'.join(spawn) + '\n', encoding='utf-8')
    (target / 'cleanup.mcfunction').write_text('\n'.join(cleanup) + '\n', encoding='utf-8')
    (server / '.sgp-benchmark-actor-count').write_text(f'{players}\n', encoding='utf-8')

    # Minecraft's normal default is 20. Keep at least that value, but grow it
    # automatically with the resolved benchmark instead of imposing a harness cap.
    set_server_property(server / 'server.properties', 'max-players', str(max(20, players+1)))


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
    measurement_reset = [
        '#> sgp.bench:generated/active/measurement_reset',
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
    for _label, scoreholder in plan_counter_specs(plan).items():
        measurement_reset.append(f'scoreboard players set {scoreholder} sgp.bench 0')

    for name, lines in (
        ('setup', setup),
        ('tick', tick),
        ('teardown', teardown),
        ('measurement_reset', measurement_reset),
    ):
        (target / f'{name}.mcfunction').write_text('\n'.join(lines) + '\n', encoding='utf-8')


def plan_total_players(plan: list[PlanComponent]) -> int:
    return sum(component.players for component in plan)


def plan_counter_specs(plan: list[PlanComponent]) -> dict[str, str]:
    counters: dict[str, str] = {}
    for component in plan:
        for name, scoreholder in component.counters.items():
            label = f'{component.scenario}.{name}'
            previous = counters.get(label)
            if previous is not None and previous != scoreholder:
                raise BenchmarkError(f'Counter {label!r} resolves to multiple score holders')
            counters[label] = scoreholder
    return dict(sorted(counters.items()))


def read_workload_counters(server: ServerProcess, plan: list[PlanComponent]) -> dict[str, int | None]:
    return {
        label: server.score(scoreholder)
        for label, scoreholder in plan_counter_specs(plan).items()
    }


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
    actors = datapack_bench / 'actors'
    for name in ('spawn.mcfunction', 'cleanup.mcfunction'):
        copy_if_file(actors / name, diagnostics / 'generated-actors' / name)

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
    plan_data = [component.as_dict() for component in plan]
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
        'plan': plan_data,
        'runs': args.runs,
        'warmup_seconds': args.warmup,
        'minecraft_version': CONFIG['minecraft_version'],
        'java_expected': CONFIG['java_version'],
        'heap': args.heap,
        'command_limit': args.command_limit,
        'git_commit': git_commit(),
        'source_sha256': source_fingerprint(),
    }
    (result_dir / 'metadata.json').write_text(json.dumps(metadata, indent=2) + '\n', encoding='utf-8')

    server: ServerProcess | None = None
    profiles: list[ParsedProfile] = []
    counters: list[dict] = []
    phase = 'preparing benchmark server'
    try:
        if not args.reuse_server:
            prepare_server(server_dir, cache_dir)
        elif not (server_dir / SERVER_MARKER).is_file() or not (server_dir / 'server.jar').is_file():
            raise BenchmarkError(f'--reuse-server was requested but {server_dir} is not prepared')
        elif (server_dir / INVALID_MARKER).exists():
            raise BenchmarkInvalidError('Refusing to reuse an interrupted benchmark world; omit --reuse-server')

        phase = 'compiling benchmark runtime'
        compile_actor_pool(server_dir, total_players)
        compile_active_plan(server_dir, plan)

        server = ServerProcess(server_dir, args.java, args.heap)
        phase = 'starting Minecraft server'
        print('Starting Minecraft server ...')
        server.start(timeout=args.startup_timeout)

        phase = 'setting benchmark command limit'
        server.send(f'gamerule minecraft:max_command_sequence_length {args.command_limit}')
        server.send('execute store result score #command_limit sgp.bench run gamerule minecraft:max_command_sequence_length')
        server.require_score('#command_limit', args.command_limit)

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
            require_ray_entities(server, plan_data)
            require_diorama_entities(server, plan_data)

            phase = f'run {run_number}/{args.runs} warm-up'
            server.sleep_alive(args.warmup)
            require_ray_entities(server, plan_data)
            require_diorama_entities(server, plan_data)

            phase = f'run {run_number}/{args.runs} profiling'
            server.send('function sgp.bench:measurement_reset')
            profile_dir = server_dir / 'debug/profiling'
            previous = {path.resolve() for path in profile_dir.glob('*.zip')} if profile_dir.is_dir() else set()
            print(f'Run {run_number}/{args.runs}: /perf')
            server.send('perf start')
            # Preserve the raw profile as part of the wait itself. Minecraft writes
            # profiling archives asynchronously and, on Windows, a just-validated
            # source path can briefly disappear before a separate copy operation.
            destination = result_dir / f'run-{run_number:02d}.zip'
            wait_for_new_profile(
                server_dir, previous, server, timeout=args.profile_timeout, destination=destination
            )
            server.send('scoreboard players set #enabled sgp.bench 0')

            server.send('execute store result score #actual_players sgp.bench if entity @a[tag=sgp.bench.actor]')
            server.require_score('#actual_players', total_players)
            require_ray_entities(server, plan_data)
            require_diorama_entities(server, plan_data)
            workload = read_workload_counters(server, plan)
            missing_counters = [name for name, value in workload.items() if value is None]
            if missing_counters:
                raise BenchmarkError(
                    f'Workload counters were not readable after profiling: {", ".join(missing_counters)}'
                )
            count = {
                'ticks': server.score('#ticks'),
                'workload': workload,
            }
            counters.append(count)

            phase = f'run {run_number}/{args.runs} parsing profile'
            parsed = parse_profile(destination)
            run_data = profile_to_dict(parsed, count)
            (result_dir / f'run-{run_number:02d}.json').write_text(
                json.dumps(run_data, indent=2) + '\n', encoding='utf-8'
            )
            phase = f'run {run_number}/{args.runs} validating completed workload'
            validated = validate_ray_workload(run_data, plan_data)
            validated.update(validate_diorama_workload(run_data, plan_data))
            if validated:
                run_data['validated_workload'] = validated
                (result_dir / f'run-{run_number:02d}.json').write_text(
                    json.dumps(run_data, indent=2) + '\n', encoding='utf-8'
                )
                print(f'Run {run_number}/{args.runs}: verified workload {validated}')
            profiles.append(parsed)
            print(
                f'Run {run_number}/{args.runs}: captured {parsed.tick_span or "?"} ticks, '
                f'tick median={format_number(parsed.tick_median_ms, 3)} ms, '
                f'p95={format_number(parsed.tick_p95_ms, 3)} ms, '
                f'commandFunctions={format_number(parsed.command_functions_percent)}%'
            )

            phase = f'run {run_number}/{args.runs} teardown'
            server.send('function sgp.bench:reset')
            server.sleep_alive(0.5)
            server.require_score('#plan_ready', 0)
            server.require_score('#players', 0)
            require_ray_entities(server, plan_data, after_reset=True)
            require_diorama_entities(server, plan_data, after_reset=True)

        if not profiles:
            raise BenchmarkError('No profiles were captured')
        phase = 'stopping Minecraft server'
        server.stop()
        server.check_health()
        copy_if_file(server_dir / 'benchmark-console.log', result_dir / 'diagnostics/benchmark-console.log')
        phase = 'writing summary'
        write_summary(result_dir, scenario, params, args.warmup, profiles, counters, plan=plan,
                      command_limit=args.command_limit)
        mark_success(result_dir, metadata)
    except Exception as exc:
        stop_error = None
        if server is not None:
            try:
                server.stop()
            except Exception as stop_exc:  # Diagnostics should survive teardown failures too.
                stop_error = stop_exc
        write_failure_bundle(result_dir, metadata, phase, exc, server_dir, server, plan)
        if isinstance(exc, BenchmarkInvalidError) and (server_dir / SERVER_MARKER).is_file():
            (server_dir / INVALID_MARKER).write_text(str(exc) + '\n', encoding='utf-8')
        if stop_error is not None:
            (result_dir / 'diagnostics/server-stop-error.txt').write_text(
                f'{type(stop_error).__name__}: {stop_error}\n', encoding='utf-8'
            )
        print(f'Failure diagnostics: {result_dir}', file=sys.stderr)
        raise

    print(f'\nResults: {result_dir}')
    print(f'Summary: {result_dir / "summary.md"}')
    return result_dir


def load_suite(reference: str) -> tuple[Path, dict]:
    direct = Path(reference)
    if direct.is_file():
        path = direct.resolve()
    else:
        path = (BENCHMARKS / 'suites' / f'{reference}.json').resolve()
    if not path.is_file():
        raise BenchmarkError(f'Unknown benchmark suite {reference!r}; expected {path}')
    try:
        data = json.loads(path.read_text(encoding='utf-8'))
    except json.JSONDecodeError as exc:
        raise BenchmarkError(f'{path}: invalid JSON: {exc}') from exc
    if not isinstance(data, dict) or not isinstance(data.get('name'), str) or not data['name']:
        raise BenchmarkError(f'{path}: suite name must be a non-empty string')
    if not isinstance(data.get('description'), str):
        raise BenchmarkError(f'{path}: suite description must be a string')
    if not isinstance(data.get('benchmarks'), list) or not data['benchmarks']:
        raise BenchmarkError(f'{path}: benchmarks must be a non-empty list')
    defaults = data.get('defaults', {})
    if not isinstance(defaults, dict):
        raise BenchmarkError(f'{path}: defaults must be an object')
    if 'runs' in defaults and (not isinstance(defaults['runs'], int) or defaults['runs'] < 1):
        raise BenchmarkError(f'{path}: defaults.runs must be >= 1')
    if 'warmup' in defaults and (not isinstance(defaults['warmup'], (int, float)) or defaults['warmup'] < 0):
        raise BenchmarkError(f'{path}: defaults.warmup must be >= 0')
    return path, data


def expand_suite_cases(suite: dict, scenarios: dict[str, dict], runs_override: int | None = None,
                       warmup_override: float | None = None) -> list[dict]:
    defaults = suite.get('defaults', {})
    cases: list[dict] = []
    for entry_index, entry in enumerate(suite['benchmarks'], 1):
        if not isinstance(entry, dict) or not isinstance(entry.get('scenario'), str):
            raise BenchmarkError(f'Suite {suite["name"]}: benchmark {entry_index} must reference a scenario')
        scenario_name = entry['scenario']
        if scenario_name not in scenarios:
            raise BenchmarkError(f'Suite {suite["name"]}: unknown scenario {scenario_name!r}')
        fixed_players = entry.get('players')
        if fixed_players is not None and not isinstance(fixed_players, int):
            raise BenchmarkError(f'Suite {suite["name"]}: {scenario_name}.players must be an integer')
        fixed_params = entry.get('parameters', {})
        if not isinstance(fixed_params, dict) or any(
            not isinstance(name, str) or not isinstance(value, int) for name, value in fixed_params.items()
        ):
            raise BenchmarkError(f'Suite {suite["name"]}: {scenario_name}.parameters must contain integers')
        matrix = entry.get('matrix', {})
        if not isinstance(matrix, dict):
            raise BenchmarkError(f'Suite {suite["name"]}: {scenario_name}.matrix must be an object')
        for name, values in matrix.items():
            if not isinstance(name, str) or not isinstance(values, list) or not values or any(
                not isinstance(value, int) for value in values
            ):
                raise BenchmarkError(
                    f'Suite {suite["name"]}: matrix {scenario_name}.{name} must be a non-empty integer list'
                )
        if 'players' in matrix and fixed_players is not None:
            raise BenchmarkError(f'Suite {suite["name"]}: {scenario_name} defines players both fixed and in matrix')
        overlap = set(fixed_params) & set(matrix)
        if overlap:
            raise BenchmarkError(
                f'Suite {suite["name"]}: {scenario_name} defines {sorted(overlap)} both fixed and in matrix'
            )

        keys = list(matrix)
        products = itertools.product(*(matrix[key] for key in keys)) if keys else [()]
        for values in products:
            varied = dict(zip(keys, values))
            players = varied.pop('players', fixed_players)
            params = {**fixed_params, **varied}
            raw_params = [f'{name}={value}' for name, value in params.items()]
            # Reuse normal scenario validation, including composite restrictions and parameter bounds.
            _selected, resolved_params, plan = resolve_plan(scenarios, scenario_name, players, raw_params)
            case_runs = runs_override if runs_override is not None else entry.get('runs', defaults.get('runs', 5))
            case_warmup = (
                warmup_override if warmup_override is not None
                else entry.get('warmup', defaults.get('warmup', 5.0))
            )
            if not isinstance(case_runs, int) or case_runs < 1:
                raise BenchmarkError(f'Suite {suite["name"]}: runs must be >= 1 for {scenario_name}')
            if not isinstance(case_warmup, (int, float)) or case_warmup < 0:
                raise BenchmarkError(f'Suite {suite["name"]}: warmup must be >= 0 for {scenario_name}')
            cases.append({
                'scenario': scenario_name,
                'players': players,
                'parameters': params,
                'resolved_parameters': resolved_params,
                'total_players': plan_total_players(plan),
                'runs': case_runs,
                'warmup': float(case_warmup),
            })
    return cases


def case_slug(case: dict) -> str:
    parts = [case['scenario']]
    if case.get('players') is not None:
        parts.append(f'p{case["players"]}')
    for name, value in sorted(case.get('parameters', {}).items()):
        parts.append(f'{name}-{value}')
    return re.sub(r'[^a-zA-Z0-9_.-]+', '-', '_'.join(parts)).strip('-') or 'case'


def result_summary_metrics(result_dir: Path) -> dict:
    metadata_path = result_dir / 'metadata.json'
    if not metadata_path.is_file():
        return {'status': 'failed'}
    metadata = json.loads(metadata_path.read_text(encoding='utf-8'))
    if metadata.get('status') != 'complete':
        return {'status': metadata.get('status', 'failed')}
    _metadata, runs = load_result_directory(result_dir)
    return {
        'status': 'complete',
        'tick_median_ms': nested_numeric_median(runs, 'tick_time_ms', 'median'),
        'tick_p95_ms': nested_numeric_median(runs, 'tick_time_ms', 'p95'),
        'command_functions_percent': numeric_median(runs, 'command_functions_percent'),
        'workload_counters': workload_counter_medians(runs),
    }


def write_suite_summary(suite_dir: Path, suite: dict, records: list[dict]):
    lines = [
        f'# SGP benchmark suite: `{suite["name"]}`',
        '',
        suite['description'],
        '',
        '| # | Scenario | Players | Parameters | Runs | Tick median | Tick p95 | commandFunctions | Workload counters | Status | Result |',
        '| ---: | --- | ---: | --- | ---: | ---: | ---: | ---: | --- | --- | --- |',
    ]
    for record in records:
        metrics = record.get('metrics', {})
        counters = metrics.get('workload_counters', {})
        counter_text = ', '.join(f'{name}={value:g}' for name, value in sorted(counters.items())) or '—'
        params = json.dumps(record['case'].get('parameters', {}), sort_keys=True, separators=(',', ':'))
        status = metrics.get('status', record.get('status', 'failed'))
        result_text = '—'
        if record.get('result_dir'):
            relative = Path(record['result_dir']).relative_to(suite_dir)
            summary_path = relative / 'summary.md'
            result_text = f'[summary.md]({summary_path.as_posix()})'
        lines.append(
            f'| {record["index"]} | `{record["case"]["scenario"]}` | {record["case"]["total_players"]} | '
            f'`{params}` | {record["case"]["runs"]} | {format_number(metrics.get("tick_median_ms"), 3)} ms | '
            f'{format_number(metrics.get("tick_p95_ms"), 3)} ms | '
            f'{format_number(metrics.get("command_functions_percent"))}% | {counter_text} | {status} | {result_text} |'
        )
    lines.append('')
    (suite_dir / 'summary.md').write_text('\n'.join(lines), encoding='utf-8')


def run_suite(args):
    suite_path, suite = load_suite(args.suite)
    scenarios = load_scenarios()
    cases = expand_suite_cases(suite, scenarios, args.runs, args.warmup)
    timestamp = datetime.now().strftime('%Y-%m-%d_%H.%M.%S.%f')[:-3]
    suite_dir = args.results_dir.resolve() / f'{timestamp}_suite-{suite["name"]}'
    suite_dir.mkdir(parents=True, exist_ok=False)
    records: list[dict] = []
    suite_metadata = {
        'created_at': datetime.now().astimezone().isoformat(),
        'name': suite['name'],
        'description': suite['description'],
        'suite_file': str(suite_path),
        'source_sha256': source_fingerprint(),
        'command_limit': args.command_limit,
        'cases': cases,
    }
    (suite_dir / 'suite.json').write_text(json.dumps(suite_metadata, indent=2) + '\n', encoding='utf-8')

    failed = 0
    for index, case in enumerate(cases, 1):
        print(f'\n=== Suite {suite["name"]}: case {index}/{len(cases)}: {case_slug(case)} ===')
        case_root = suite_dir / f'{index:02d}_{case_slug(case)}'
        child = argparse.Namespace(
            scenario=case['scenario'],
            players=case['players'],
            param=[f'{name}={value}' for name, value in case['parameters'].items()],
            runs=case['runs'],
            warmup=case['warmup'],
            java=args.java,
            heap=args.heap,
            command_limit=args.command_limit,
            server_dir=args.server_dir,
            cache_dir=args.cache_dir,
            results_dir=case_root,
            reuse_server=False,
            startup_timeout=args.startup_timeout,
            profile_timeout=args.profile_timeout,
        )
        result_dir = None
        error = None
        try:
            result_dir = run_benchmark(child)
        except Exception as exc:
            failed += 1
            error = f'{type(exc).__name__}: {exc}'
            if case_root.is_dir():
                candidates = sorted(path for path in case_root.iterdir() if path.is_dir())
                if candidates:
                    result_dir = candidates[-1]
        metrics = result_summary_metrics(result_dir) if result_dir is not None else {'status': 'failed'}
        record = {
            'index': index,
            'case': case,
            'result_dir': str(result_dir) if result_dir is not None else None,
            'status': metrics.get('status', 'failed'),
            'metrics': metrics,
        }
        if error:
            record['error'] = error
        records.append(record)
        (suite_dir / 'suite-results.json').write_text(json.dumps(records, indent=2) + '\n', encoding='utf-8')
        write_suite_summary(suite_dir, suite, records)

    print(f'\nSuite results: {suite_dir}')
    print(f'Suite summary: {suite_dir / "summary.md"}')
    if failed:
        raise BenchmarkError(f'{failed}/{len(cases)} suite cases failed; see {suite_dir / "summary.md"}')
    return suite_dir


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


def workload_counter_medians(runs: list[dict]) -> dict[str, float]:
    values: dict[str, list[float]] = defaultdict(list)
    for run in runs:
        counters = run.get('harness_counters_after_profile_write', {}).get('workload', {})
        if not isinstance(counters, dict):
            continue
        for name, value in counters.items():
            if isinstance(name, str) and isinstance(value, (int, float)):
                values[name].append(float(value))
    return {name: float(median(items)) for name, items in values.items()}


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
    for path, metadata, runs in ((args.before, before_meta, before_runs), (args.after, after_meta, after_runs)):
        if metadata.get('status') != 'complete':
            raise BenchmarkInvalidError(f'{path}: only complete benchmark invocations can be compared')
        if len(runs) != metadata['runs']:
            raise BenchmarkInvalidError(f'{path}: incomplete set of benchmark runs')
        for run in runs:
            validate_ray_workload(run, metadata['plan'])
            validate_diorama_workload(run, metadata['plan'])
    identity_fields = (
        'scenario', 'parameters', 'plan', 'command_limit',
        'heap', 'warmup_seconds', 'minecraft_version',
    )
    before_identity = tuple((field, before_meta.get(field)) for field in identity_fields)
    after_identity = tuple((field, after_meta.get(field)) for field in identity_fields)
    if before_identity != after_identity and not args.allow_mismatch:
        raise BenchmarkError(
            'Benchmark configurations do not match. Use --allow-mismatch only when that is intentional.\n'
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
    before_workload = workload_counter_medians(before_runs)
    after_workload = workload_counter_medians(after_runs)

    lines = [
        '# SGP benchmark comparison',
        '',
        f'- Before: `{args.before.resolve()}`',
        f'- After: `{args.after.resolve()}`',
        f'- Scenario before/after: `{before_meta.get("scenario")}` / `{after_meta.get("scenario")}`',
        f'- Parameters before: `{json.dumps(before_meta.get("parameters"), sort_keys=True)}`',
        f'- Parameters after: `{json.dumps(after_meta.get("parameters"), sort_keys=True)}`',
        f'- Runs before/after: {len(before_runs)} / {len(after_runs)}',
        f'- Command sequence limit before/after: {before_meta.get("command_limit")} / {after_meta.get("command_limit")}',
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
    if before_workload or after_workload:
        lines += ['', '## Workload counters', '', '| Counter | Before median | After median | Change |',
                  '| --- | ---: | ---: | ---: |']
        for name in sorted(set(before_workload) | set(after_workload)):
            before_value = before_workload.get(name)
            after_value = after_workload.get(name)
            lines.append(
                f'| `{name}` | {format_number(before_value)} | {format_number(after_value)} | '
                f'{relative_change(before_value, after_value)} |'
            )

    before_entries = entry_medians(before_runs)
    after_entries = entry_medians(after_runs)
    command_index, function_index = build_source_index()
    changes = []
    for name in set(before_entries) | set(after_entries):
        if name in {'unspecified', 'minecraft:tick'}:
            continue
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
        'and workload counters are comparable before attributing a difference to a datapack change.',
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
            rendered = []
            for name, spec in scenario['parameters'].items():
                upper = spec.get('max')
                range_text = f'{spec["min"]}..{upper}' if upper is not None else f'{spec["min"]}..'
                rendered.append(f'{name}={parameter_default(name, spec)} ({range_text})')
            print(f'  parameters: {", ".join(rendered)}')


def prepare_command(args):
    prepare_server(args.server_dir.resolve(), args.cache_dir.resolve())


def command_limit_argument(value: str) -> int:
    value = int(value)
    if not 1 <= value <= 2147483647:
        raise argparse.ArgumentTypeError('command limit must be between 1 and 2147483647')
    return value


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
    run_parser.add_argument('--command-limit', type=command_limit_argument, default=65536,
                            help='Explicit benchmark-world command sequence limit (default: 65536)')
    run_parser.add_argument('--server-dir', type=Path, default=DEFAULT_SERVER)
    run_parser.add_argument('--cache-dir', type=Path, default=DEFAULT_CACHE)
    run_parser.add_argument('--results-dir', type=Path, default=DEFAULT_RESULTS)
    run_parser.add_argument('--reuse-server', action='store_true', help='Do not rebuild the staged server/world before this invocation')
    run_parser.add_argument('--startup-timeout', type=float, default=120.0)
    run_parser.add_argument('--profile-timeout', type=float, default=45.0)
    run_parser.set_defaults(func=run_benchmark)

    suite_parser = subparsers.add_parser('suite', help='Run a JSON benchmark suite/matrix')
    suite_parser.add_argument('suite', help='Suite name under benchmarks/suites/ or a JSON path')
    suite_parser.add_argument('--runs', type=int, help='Override runs for every suite case')
    suite_parser.add_argument('--warmup', type=float, help='Override warm-up seconds for every suite case')
    suite_parser.add_argument('--java', default='java')
    suite_parser.add_argument('--heap', default=CONFIG['heap'])
    suite_parser.add_argument('--command-limit', type=command_limit_argument, default=65536,
                              help='Command sequence limit applied equally to all suite cases')
    suite_parser.add_argument('--server-dir', type=Path, default=DEFAULT_SERVER)
    suite_parser.add_argument('--cache-dir', type=Path, default=DEFAULT_CACHE)
    suite_parser.add_argument('--results-dir', type=Path, default=DEFAULT_RESULTS)
    suite_parser.add_argument('--startup-timeout', type=float, default=120.0)
    suite_parser.add_argument('--profile-timeout', type=float, default=45.0)
    suite_parser.set_defaults(func=run_suite)

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
    runs = getattr(args, 'runs', 1)
    warmup = getattr(args, 'warmup', 0)
    if runs is not None and runs < 1:
        parser.error('--runs must be at least 1')
    if warmup is not None and warmup < 0:
        parser.error('--warmup cannot be negative')
    try:
        args.func(args)
    except (BenchmarkError, ValueError, OSError, urllib.error.URLError) as exc:
        print(f'benchmark error: {exc}', file=sys.stderr)
        return 2
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
