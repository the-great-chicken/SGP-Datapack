"""Comparison of completed benchmark result directories."""
from __future__ import annotations

from collections import defaultdict
from pathlib import Path
from statistics import median
import json

from .errors import BenchmarkError, BenchmarkInvalidError
from .profiler import build_source_index, format_number, source_hint
from .validators import validate_persisted_run

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
            validate_persisted_run(run, metadata['plan'], metadata.get('validators'))
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
