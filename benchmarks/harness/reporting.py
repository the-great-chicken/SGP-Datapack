"""Benchmark summaries and source identity metadata."""
from __future__ import annotations

from collections import defaultdict
from pathlib import Path
from statistics import median
import hashlib
import json
import subprocess

from .models import ParsedProfile, PlanComponent, ProfileEntry
from .profiler import benchmark_source_files, build_source_index, format_number, source_hint
from .runtime import plan_total_players
from .settings import BENCHMARKS, DEFAULT_COMMAND_LIMIT, ROOT

def _megabytes(value: float | None) -> str:
    return 'n/a' if value is None else f'{value:.0f} MB'


def command_limit_summary(command_limit: int, calibration: dict | None) -> str:
    if not calibration:
        return f'- Command sequence limit: {command_limit} (explicit)'
    if not calibration.get('calibrated'):
        return f'- Command sequence limit: {command_limit} (automatic default; calibration not needed)'
    failed = calibration.get('known_failing_limit')
    gap = calibration.get('relative_gap_percent')
    detail = f'; known failure at {failed}' if isinstance(failed, int) else ''
    if isinstance(gap, (int, float)):
        detail += f'; pass/fail gap {gap:.2f}%'
    return f'- Command sequence limit: {command_limit} (auto-calibrated{detail})'


def write_summary(result_dir: Path, scenario: dict, params: dict[str, int], warmup: float,
                  profiles: list[ParsedProfile], counters: list[dict],
                  plan: list[PlanComponent] | None = None, command_limit: int = DEFAULT_COMMAND_LIMIT,
                  command_limit_calibration: dict | None = None, metadata: dict | None = None):
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
        command_limit_summary(command_limit, command_limit_calibration),
        '- Profiler: vanilla dedicated-server `/perf`',
        f'- Source: {describe_source(metadata)}',
    ]
    restarts = (metadata or {}).get('jvm_restarts_before_runs') or []
    if restarts:
        lines.append(
            f'- JVM restarted before run(s) {", ".join(str(run) for run in restarts)}: more than half the heap '
            'was still live after the previous run (PackTest dummies never drain their packets), so each of '
            'those runs starts on a fresh heap.'
        )
    lines.append('')
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
        '| Run | Profile ticks | Mean MSPT | commandFunctions | commandFunctions ms/tick | Commands/tick | '
        'Entities ms/tick | GC pauses ms/tick | Heap after GC | '
        'Tick period median | Tick period p95 | Tick period max | Driver ticks |',
        '| ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: |',
    ]
    for i, (profile, count) in enumerate(zip(profiles, counters), 1):
        lines.append(
            f'| {i} | {format_number(profile.tick_span)} | {format_number(profile.mean_mspt_ms)} ms | '
            f'{format_number(profile.command_functions_percent)}% | '
            f'{format_number(profile.command_functions_ms_per_tick)} ms | '
            f'{format_number(profile.commands_executed_per_tick, 0)} | '
            f'{format_number(profile.entities_ms_per_tick, 3)} ms | '
            f'{format_number(profile.gc_ms_per_tick, 3)} ms | {_megabytes(profile.gc_heap_after_mb)} | '
            f'{format_number(profile.tick_period_median_ms)} ms | {format_number(profile.tick_period_p95_ms)} ms | '
            f'{format_number(profile.tick_period_max_ms)} ms | {format_number(count.get("ticks"))} |'
        )

    mspt_values = [p.mean_mspt_ms for p in profiles if p.mean_mspt_ms is not None]
    command_values = [p.command_functions_percent for p in profiles if p.command_functions_percent is not None]
    cf_ms_values = [p.command_functions_ms_per_tick for p in profiles if p.command_functions_ms_per_tick is not None]
    tps_values = [p.effective_tps for p in profiles if p.effective_tps is not None]
    period_medians = [p.tick_period_median_ms for p in profiles if p.tick_period_median_ms is not None]
    period_p95s = [p.tick_period_p95_ms for p in profiles if p.tick_period_p95_ms is not None]
    period_maxes = [p.tick_period_max_ms for p in profiles if p.tick_period_max_ms is not None]
    command_counts = [p.commands_executed_per_tick for p in profiles if p.commands_executed_per_tick is not None]
    entity_values = [p.entities_ms_per_tick for p in profiles if p.entities_ms_per_tick is not None]
    gc_values = [p.gc_ms_per_tick for p in profiles if p.gc_ms_per_tick is not None]
    heap_values = [p.gc_heap_after_mb for p in profiles if p.gc_heap_after_mb is not None]
    if mspt_values or command_values or tps_values or period_medians or period_p95s or period_maxes:
        lines += ['', '## Aggregate', '']
        if mspt_values:
            lines.append(
                f'- Median run mean MSPT: **{median(mspt_values):.3f} ms** '
                f'(range {min(mspt_values):.3f}–{max(mspt_values):.3f} ms); '
                'server work per tick from the `/perf` root `tick` share.'
            )
        if command_values:
            per_tick = f', **{median(cf_ms_values):.3f} ms/tick**' if cf_ms_values else ''
            lines.append(
                f'- Median `commandFunctions`: **{median(command_values):.2f}%** '
                f'(range {min(command_values):.2f}–{max(command_values):.2f}%){per_tick}.'
            )
        if tps_values:
            lines.append(
                f'- Median effective TPS during capture: **{median(tps_values):.2f}** '
                f'(range {min(tps_values):.2f}–{max(tps_values):.2f}).'
            )
        if period_medians:
            lines.append(
                f'- Median run tick period median: **{median(period_medians):.3f} ms** '
                f'(range {min(period_medians):.3f}–{max(period_medians):.3f} ms). Wall-clock tick interval '
                'from `ticking.csv`; it only reflects work while the server is saturated.'
            )
        if period_p95s:
            lines.append(
                f'- Median run tick period p95: **{median(period_p95s):.3f} ms** '
                f'(range {min(period_p95s):.3f}–{max(period_p95s):.3f} ms).'
            )
        if period_maxes:
            lines.append(
                f'- Median run maximum tick period: **{median(period_maxes):.3f} ms** '
                f'(range {min(period_maxes):.3f}–{max(period_maxes):.3f} ms).'
            )
        if command_counts:
            lines.append(
                f'- Median commands executed per tick: **{median(command_counts):.0f}** '
                f'(range {min(command_counts):.0f}–{max(command_counts):.0f}); datapack commands whose '
                'execute section ran, from the `/perf` command sections.'
            )
        if entity_values:
            lines.append(
                f'- Median entity ticking: **{median(entity_values):.3f} ms/tick** '
                f'(range {min(entity_values):.3f}–{max(entity_values):.3f} ms/tick), outside command functions; '
                'see the entity table below.'
            )
        if gc_values:
            lines.append(
                f'- Median GC pause time: **{median(gc_values):.3f} ms/tick** '
                f'(range {min(gc_values):.3f}–{max(gc_values):.3f} ms/tick). JVM stop-the-world pauses '
                'during the capture; `/perf` attributes them to whatever section was running.'
            )
        if heap_values:
            capacity = next((p.gc_heap_capacity_mb for p in profiles if p.gc_heap_capacity_mb), None)
            capacity_text = f' of {capacity:.0f} MB' if capacity else ''
            lines.append(
                f'- Heap live after GC, per run: {", ".join(f"{value:.0f}" for value in heap_values)} MB'
                f'{capacity_text}. Growth across runs means the session retains memory (PackTest '
                'dummies never drain their packets) and later runs are GC-bound.'
            )

    type_values: dict[str, list[float]] = defaultdict(list)
    for profile in profiles:
        for name, value in profile.entity_type_ms_per_tick().items():
            type_values[name].append(value)
    if type_values:
        lines += ['', '## Entity ticking by type', '',
                  'Median ms/tick of the vanilla per-entity-type profiler sections (players included).', '',
                  '| Entity type | Median ms/tick |', '| --- | ---: |']
        ranked = sorted(type_values.items(), key=lambda item: median(item[1]), reverse=True)
        for name, values in ranked[:12]:
            if median(values) >= 0.005:
                lines.append(f'| `{name}` | {median(values):.3f} ms |')

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
    """Hash all source that can affect staging, execution, or validation."""
    digest = hashlib.sha256()
    files = list(benchmark_source_files())
    files.extend(path for path in (BENCHMARKS / 'scenarios').rglob('*') if path.is_file())
    files.extend(path for path in (BENCHMARKS / 'suites').rglob('*') if path.is_file())
    files.extend(path for path in (BENCHMARKS / 'harness').rglob('*.py') if path.is_file())
    files.extend(path for path in (ROOT / 'sgp_tools').rglob('*.py') if path.is_file())
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


def git_dirty() -> bool | None:
    """True when tracked or untracked (non-ignored) files differ from HEAD; None outside git.

    Untracked files count: source_fingerprint() hashes them too, so an untracked
    function changes results without changing the commit. results/, the staged
    server and the dependency cache are gitignored and never mark a run dirty.
    """
    try:
        result = subprocess.run(
            ['git', 'status', '--porcelain'], cwd=ROOT, capture_output=True, text=True, check=True, timeout=10
        )
        return bool(result.stdout.strip())
    except Exception:
        return None


def describe_source(metadata: dict | None) -> str:
    commit = (metadata or {}).get('git_commit')
    text = f'commit `{commit[:12]}`' if isinstance(commit, str) and commit else 'commit unknown'
    dirty = (metadata or {}).get('git_dirty')
    if dirty is True:
        return text + ' **(dirty working tree)**'
    if dirty is False:
        return text + ' (clean)'
    return text
