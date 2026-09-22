"""Local SGP datapack benchmark runner.

The runner stages a fresh plugin-free Fabric server, uses PackTest dummies to
create deterministic workloads, starts vanilla /perf, preserves every raw
profile zip, and writes a compact commandFunctions summary.

Requires Python 3.12+ and Java 25. The first run downloads the same pinned
Fabric/PackTest/Bookshelf/Actionbar Mixer dependencies used by CI.
"""
from __future__ import annotations

from pathlib import Path
import argparse
import sys
import urllib.error

from .calibration import run_benchmark
from .comparison import compare_results
from .errors import BenchmarkError
from .profiler import parse_archives
from .scenarios import load_scenarios, parameter_default
from .settings import (
    CONFIG,
    DEFAULT_CACHE,
    DEFAULT_RESULTS,
    DEFAULT_SERVER,
    MAX_COMMAND_LIMIT,
)
from .staging import prepare_server
from .suites import run_suite


def list_scenarios(_args) -> None:
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


def prepare_command(args) -> None:
    prepare_server(args.server_dir.resolve(), args.cache_dir.resolve())


def command_limit_argument(value: str) -> int:
    value = int(value)
    if not 1 <= value <= MAX_COMMAND_LIMIT:
        raise argparse.ArgumentTypeError(f'command limit must be between 1 and {MAX_COMMAND_LIMIT}')
    return value


def _add_execution_options(parser: argparse.ArgumentParser, command_limit_help: str) -> None:
    parser.add_argument('--java', default='java')
    parser.add_argument('--heap', default=CONFIG['heap'])
    parser.add_argument(
        '--command-limit', type=command_limit_argument,
        help=command_limit_help,
    )
    parser.add_argument('--server-dir', type=Path, default=DEFAULT_SERVER)
    parser.add_argument('--cache-dir', type=Path, default=DEFAULT_CACHE)
    parser.add_argument('--results-dir', type=Path, default=DEFAULT_RESULTS)
    parser.add_argument('--startup-timeout', type=float, default=120.0)
    parser.add_argument('--profile-timeout', type=float, default=45.0)


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
    run_parser.add_argument('--param', action='append', default=[], metavar='NAME=INT',
                            help='Override an atomic scenario parameter')
    run_parser.add_argument('--runs', type=int, default=5)
    run_parser.add_argument('--warmup', type=float, default=5.0,
                            help='Seconds of active workload before each /perf capture')
    _add_execution_options(
        run_parser,
        'Explicit benchmark-world command sequence limit; omitted = auto-calibrate on limit failure',
    )
    run_parser.add_argument('--reuse-server', action='store_true',
                            help='Do not rebuild the staged server/world before this invocation')
    run_parser.set_defaults(func=run_benchmark)

    suite_parser = subparsers.add_parser('suite', help='Run a JSON benchmark suite/matrix')
    suite_parser.add_argument('suite', help='Suite name under benchmarks/suites/ or a JSON path')
    suite_parser.add_argument('--runs', type=int, help='Override runs for every suite case')
    suite_parser.add_argument('--warmup', type=float, help='Override warm-up seconds for every suite case')
    _add_execution_options(
        suite_parser,
        'Explicit command sequence limit for all cases; omitted = auto-calibrate per case',
    )
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
