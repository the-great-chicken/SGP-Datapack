"""Vanilla /perf capture, parsing, and source attribution."""
from __future__ import annotations

from collections import defaultdict
from pathlib import Path
import csv
import io
import math
import re
import time
import zipfile

from .errors import BenchmarkError
from .models import ParsedProfile, ProfileEntry
from .server import ServerProcess
from .settings import BENCHMARKS, ROOT

PROFILE_LINE = re.compile(
    r'^\[(?P<depth>\d+)]\s*(?:\|\s*)*'
    r'(?P<name>.*)\((?P<count>\d+)/(?P<per_tick>\d+)\)\s+-\s+'
    r'(?P<parent>[0-9.]+)%/(?P<global>[0-9.]+)%$'
)
TIME_SPAN = re.compile(r'^Time span:\s*([0-9.]+)\s*ms$', re.MULTILINE)
TICK_SPAN = re.compile(r'^Tick span:\s*(\d+)\s*ticks$', re.MULTILINE)
VERSION = re.compile(r'^Version:\s*(.+)$', re.MULTILINE)
FUNCTION_CALL = re.compile(r'\bfunction\s+([a-z0-9_.-]+:[a-z0-9_./-]+)')

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
