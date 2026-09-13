"""Collect function-hit coverage for the staged datapack used by PackTest.

The CI-only instrument command prepends a one-time log marker to every production
function in the staged core datapack. The report command parses those markers
from the dedicated-server console log and reports function coverage per
namespace. Production files are never modified.

Usage:
  python3 .github/scripts/datapack_coverage.py instrument REPOSITORY SERVER
  python3 .github/scripts/datapack_coverage.py report REPOSITORY SERVER [--summary FILE]
"""
from pathlib import Path
import argparse
import json
import os
import re

MARKER = 'SGP_COVERAGE:'
MAP_NAME = 'datapack-coverage-map.json'
REPORT_NAME = 'datapack-coverage.json'
SUMMARY_NAME = 'datapack-coverage.md'
INSTRUMENTED_PREFIX = '# SGP CI coverage: '
MARKER_RE = re.compile(r'\bSGP_COVERAGE:(\d{6})\b')


def function_id(path, data):
    relative = path.relative_to(data)
    namespace = relative.parts[0]
    name = Path(*relative.parts[2:]).with_suffix('').as_posix()
    return f'{namespace}:{name}'


def source_test_counts(repository):
    counts = {}
    for namespace in sorted((repository / 'data').iterdir()):
        test_dir = namespace / 'test'
        if namespace.is_dir() and test_dir.is_dir():
            counts[namespace.name] = len(list(test_dir.rglob('*.mcfunction')))
    return counts


def production_functions(repository, server):
    """Return staged production functions that originate in repository/data.

    Limiting instrumentation to files that exist in the repository avoids
    measuring CI fixtures or dependencies installed into the staged pack later.
    Integration namespaces removed by prepare_core.py are naturally absent.
    """
    source_data = repository / 'data'
    staged_data = server / 'world/datapacks/SGP-Datapack/data'
    functions = []
    for staged in sorted(staged_data.glob('*/function/**/*.mcfunction')):
        relative = staged.relative_to(staged_data)
        if relative.parts[0] == 'sgp.ci':
            continue
        source = source_data / relative
        if source.is_file():
            functions.append((staged, source, function_id(staged, staged_data)))
    return functions



def instrument(repository, server):
    repository = repository.resolve()
    server = server.resolve()
    staged_data = server / 'world/datapacks/SGP-Datapack/data'
    if not staged_data.is_dir():
        raise ValueError(f'Staged datapack not found: {staged_data}')

    map_path = server / MAP_NAME
    if map_path.exists():
        raise ValueError(f'Coverage map already exists: {map_path}')

    test_counts = source_test_counts(repository)
    entries = []
    for index, (staged, source, resource) in enumerate(production_functions(repository, server), 1):
        marker_id = f'{index:06d}'
        original = staged.read_text(encoding='utf-8')
        if INSTRUMENTED_PREFIX in original:
            raise ValueError(f'Function is already instrumented: {staged}')
        prefix = (
            f'{INSTRUMENTED_PREFIX}{marker_id} {resource}\n'
            f'execute unless data storage sgp.ci:coverage c{marker_id} run say {MARKER}{marker_id}\n'
            f'data modify storage sgp.ci:coverage c{marker_id} set value 1b\n'
        )
        staged.write_text(prefix + original, encoding='utf-8')
        namespace = resource.split(':', 1)[0]
        entries.append({
            'id': marker_id,
            'namespace': namespace,
            'resource': resource,
            'path': source.relative_to(repository).as_posix(),
        })

    if not entries:
        raise ValueError('No production functions were found to instrument')

    document = {
        'schema_version': 1,
        'metric': 'function_hit',
        'functions': entries,
        'tests_per_namespace': test_counts,
    }
    map_path.write_text(json.dumps(document, indent=2, sort_keys=True) + '\n', encoding='utf-8')
    print(f'Instrumented {len(entries)} production functions for CI coverage.')


def collect_hits(console_text):
    return set(MARKER_RE.findall(console_text))


def build_report(mapping, hits):
    by_namespace = {}
    uncovered = []
    for entry in mapping['functions']:
        namespace = entry['namespace']
        metrics = by_namespace.setdefault(namespace, {
            'tests': mapping.get('tests_per_namespace', {}).get(namespace, 0),
            'functions_hit': 0,
            'functions_total': 0,
        })
        metrics['functions_total'] += 1
        if entry['id'] in hits:
            metrics['functions_hit'] += 1
        else:
            uncovered.append(entry['resource'])

    for metrics in by_namespace.values():
        total = metrics['functions_total']
        metrics['coverage_percent'] = round(metrics['functions_hit'] * 100.0 / total, 1) if total else 100.0

    total_functions = sum(item['functions_total'] for item in by_namespace.values())
    hit_functions = sum(item['functions_hit'] for item in by_namespace.values())
    total_tests = sum(item['tests'] for item in by_namespace.values())
    total = {
        'tests': total_tests,
        'functions_hit': hit_functions,
        'functions_total': total_functions,
        'coverage_percent': round(hit_functions * 100.0 / total_functions, 1) if total_functions else 100.0,
    }
    return {
        'schema_version': 1,
        'metric': 'function_hit',
        'total': total,
        'namespaces': dict(sorted(by_namespace.items())),
        'uncovered_functions': sorted(uncovered),
    }


def render_markdown(report):
    lines = [
        '## Datapack test coverage',
        '',
        'Function-hit coverage collected from the PackTest server run. A function is covered when it executes at least once; this does not measure branches or individual commands.',
        '',
        '| Namespace | Tests | Functions hit | Functions total | Coverage |',
        '| --- | ---: | ---: | ---: | ---: |',
    ]
    for namespace, metrics in report['namespaces'].items():
        lines.append(
            f"| `{namespace}` | {metrics['tests']} | {metrics['functions_hit']} | "
            f"{metrics['functions_total']} | {metrics['coverage_percent']:.1f}% |"
        )
    total = report['total']
    lines.extend([
        f"| **Total** | **{total['tests']}** | **{total['functions_hit']}** | "
        f"**{total['functions_total']}** | **{total['coverage_percent']:.1f}%** |",
        '',
    ])
    return '\n'.join(lines)


def report(repository, server, summary=None):
    repository = repository.resolve()
    server = server.resolve()
    map_path = server / MAP_NAME
    console_path = server / 'console.log'
    if not map_path.is_file():
        raise ValueError(f'Coverage map not found: {map_path}')
    if not console_path.is_file():
        raise ValueError(f'PackTest console log not found: {console_path}')

    mapping = json.loads(map_path.read_text(encoding='utf-8'))
    hits = collect_hits(console_path.read_text(encoding='utf-8', errors='replace'))
    known_ids = {entry['id'] for entry in mapping['functions']}
    unknown = sorted(hits - known_ids)
    if unknown:
        raise ValueError(f'Console contained unknown coverage ids: {unknown}')
    if known_ids and not hits:
        raise ValueError('No datapack coverage markers were emitted by the PackTest server')

    result = build_report(mapping, hits)
    markdown = render_markdown(result)
    (server / REPORT_NAME).write_text(json.dumps(result, indent=2, sort_keys=True) + '\n', encoding='utf-8')
    (server / SUMMARY_NAME).write_text(markdown, encoding='utf-8')

    summary_path = summary or os.environ.get('GITHUB_STEP_SUMMARY')
    if summary_path:
        with Path(summary_path).open('a', encoding='utf-8') as output:
            output.write(markdown)
            output.write('\n')

    print(markdown)
    print(f"Coverage: {result['total']['functions_hit']}/{result['total']['functions_total']} functions ({result['total']['coverage_percent']:.1f}%).")
    return result


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    subparsers = parser.add_subparsers(dest='command', required=True)

    instrument_parser = subparsers.add_parser('instrument')
    instrument_parser.add_argument('repository', type=Path)
    instrument_parser.add_argument('server', type=Path)

    report_parser = subparsers.add_parser('report')
    report_parser.add_argument('repository', type=Path)
    report_parser.add_argument('server', type=Path)
    report_parser.add_argument('--summary', type=Path)

    args = parser.parse_args()
    if args.command == 'instrument':
        instrument(args.repository, args.server)
    else:
        report(args.repository, args.server, args.summary)


if __name__ == '__main__':
    main()
