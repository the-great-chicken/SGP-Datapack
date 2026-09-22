"""Benchmark suite loading, matrix expansion, and execution."""
from __future__ import annotations

from datetime import datetime
from pathlib import Path
import argparse
import itertools
import json
import re

from .comparison import load_result_directory, nested_numeric_median, numeric_median, workload_counter_medians
from .errors import BenchmarkError
from .profiler import format_number
from .reporting import source_fingerprint
from .scenarios import load_scenarios, resolve_plan
from .runtime import plan_total_players
from .settings import BENCHMARKS

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
        'mean_mspt_ms': numeric_median(runs, 'mean_mspt_ms'),
        'command_functions_percent': numeric_median(runs, 'command_functions_percent'),
        'command_functions_ms_per_tick': numeric_median(runs, 'command_functions_ms_per_tick'),
        'gc_ms_per_tick': nested_numeric_median(runs, 'gc', 'ms_per_tick'),
        'tick_period_p95_ms': nested_numeric_median(runs, 'tick_period_ms', 'p95'),
        'command_limit': metadata.get('command_limit'),
        'command_limit_mode': metadata.get('command_limit_mode'),
        'workload_counters': workload_counter_medians(runs),
    }


def write_suite_summary(suite_dir: Path, suite: dict, records: list[dict]):
    lines = [
        f'# SGP benchmark suite: `{suite["name"]}`',
        '',
        suite['description'],
        '',
        '| # | Scenario | Players | Parameters | Runs | Command limit | Mean MSPT | commandFunctions | '
        'commandFunctions ms/tick | GC pauses ms/tick | Tick period p95 | Workload counters | Status | Result |',
        '| ---: | --- | ---: | --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: | --- | --- | --- |',
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
            f'`{params}` | {record["case"]["runs"]} | {format_number(metrics.get("command_limit"), 0)} | '
            f'{format_number(metrics.get("mean_mspt_ms"), 3)} ms | '
            f'{format_number(metrics.get("command_functions_percent"))}% | '
            f'{format_number(metrics.get("command_functions_ms_per_tick"), 3)} ms | '
            f'{format_number(metrics.get("gc_ms_per_tick"), 3)} ms | '
            f'{format_number(metrics.get("tick_period_p95_ms"), 3)} ms | {counter_text} | {status} | {result_text} |'
        )
    lines.append('')
    (suite_dir / 'summary.md').write_text('\n'.join(lines), encoding='utf-8')


from .calibration import run_benchmark

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
        'command_limit_mode': 'auto' if args.command_limit is None else 'explicit',
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
