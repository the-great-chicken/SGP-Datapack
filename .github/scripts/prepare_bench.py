"""Prepare a fresh plugin-free PackTest benchmark server.

Usage: python3 .github/scripts/prepare_bench.py REPOSITORY NEW_SERVER_DIRECTORY
Only NEW_SERVER_DIRECTORY is written. Existing targets are rejected.
Uses only Python's standard library.
"""
from pathlib import Path
import argparse
import importlib.util
import json
import shutil
import sys

SCRIPTS = Path(__file__).resolve().parent
_PREPARE_CORE_SPEC = importlib.util.spec_from_file_location('sgp_prepare_core', SCRIPTS / 'prepare_core.py')
if _PREPARE_CORE_SPEC is None or _PREPARE_CORE_SPEC.loader is None:
    raise RuntimeError('Could not load prepare_core.py')
_PREPARE_CORE = importlib.util.module_from_spec(_PREPARE_CORE_SPEC)
sys.modules[_PREPARE_CORE_SPEC.name] = _PREPARE_CORE
try:
    _PREPARE_CORE_SPEC.loader.exec_module(_PREPARE_CORE)
except Exception:
    sys.modules.pop(_PREPARE_CORE_SPEC.name, None)
    raise

MODULES = _PREPARE_CORE.MODULES
validate = _PREPARE_CORE.validate

_SCENARIO_SPEC = importlib.util.spec_from_file_location(
    'sgp_benchmark_scenario_validation', SCRIPTS.parent.parent / 'benchmarks/scenario_validation.py'
)
if _SCENARIO_SPEC is None or _SCENARIO_SPEC.loader is None:
    raise RuntimeError('Could not load benchmarks/scenario_validation.py')
_SCENARIO_VALIDATION = importlib.util.module_from_spec(_SCENARIO_SPEC)
sys.modules[_SCENARIO_SPEC.name] = _SCENARIO_VALIDATION
try:
    _SCENARIO_SPEC.loader.exec_module(_SCENARIO_VALIDATION)
except Exception:
    sys.modules.pop(_SCENARIO_SPEC.name, None)
    raise


def load_scenarios(repository: Path):
    scenarios = _SCENARIO_VALIDATION.load_scenarios(
        repository / 'benchmarks/scenarios', error_type=ValueError
    )
    # Staging has no runner config dependency; use the repository default.
    config = json.loads((repository / 'benchmarks/config.json').read_text(encoding='utf-8'))
    _SCENARIO_VALIDATION.validate_scenario_graph(
        scenarios, int(config['default_players']), error_type=ValueError
    )
    return scenarios


def function_file(data: Path, identifier: str):
    namespace, name = identifier.split(':', 1)
    return data / namespace / 'function' / f'{name}.mcfunction'


def validate_scenarios(data: Path, scenarios):
    # Graph/schema validation is shared with the runtime loader. This staging-only
    # pass verifies that atomic entry points actually exist in the staged pack.
    for scenario in scenarios.values():
        if 'components' in scenario:
            continue
        for key in ('setup', 'tick', 'teardown'):
            path = function_file(data, scenario[key])
            if not path.is_file():
                raise ValueError(f'Scenario {scenario["name"]}: missing {key} function {scenario[key]}')


def append_tag_value(path: Path, value: str):
    document = json.loads(path.read_text(encoding='utf-8'))
    values = document.setdefault('values', [])
    if value not in values:
        values.append(value)
    path.write_text(json.dumps(document, indent=2) + '\n', encoding='utf-8')


def prepare(repository: Path, server: Path):
    repository = repository.resolve()
    server = server.resolve()
    if server.exists():
        raise ValueError(f'Refusing to overwrite an existing server directory: {server}')

    validate(repository / 'data')
    scenarios = load_scenarios(repository)

    pack = server / 'world/datapacks/SGP-Datapack'
    (pack / 'data').mkdir(parents=True)
    for child in sorted((repository / 'data').iterdir()):
        if child.name in MODULES:
            continue
        target = pack / 'data' / child.name
        if child.is_dir():
            shutil.copytree(child, target)
            # PackTest unit tests are intentionally absent from the benchmark pack.
            shutil.rmtree(target / 'test', ignore_errors=True)
        else:
            shutil.copy2(child, target)
    shutil.copy2(repository / 'pack.mcmeta', pack / 'pack.mcmeta')

    fixtures = repository / 'benchmarks/fixtures/data'
    if not fixtures.is_dir():
        raise ValueError(f'Missing benchmark fixtures: {fixtures}')
    for source in fixtures.rglob('*'):
        if not source.is_file():
            continue
        relative = source.relative_to(fixtures)
        destination = pack / 'data' / relative
        if destination.exists():
            raise ValueError(f'Benchmark fixture collides with production resource: {relative}')
        destination.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(source, destination)

    validate_scenarios(pack / 'data', scenarios)
    append_tag_value(pack / 'data/minecraft/tags/function/load.json', 'sgp.bench:load')
    append_tag_value(pack / 'data/minecraft/tags/function/tick.json', 'sgp.bench:tick')
    validate(pack / 'data', core=True)

    (server / 'server.properties').write_text(
        '\n'.join([
            'level-name=world',
            'level-type=minecraft:flat',
            'level-seed=sgp-benchmark',
            'generate-structures=false',
            'spawn-animals=false',
            'spawn-monsters=false',
            'spawn-npcs=false',
            'function-permission-level=4',
            'online-mode=false',
            'spawn-protection=0',
            'view-distance=5',
            'simulation-distance=5',
            'motd=SGP local benchmark server',
            '',
        ]),
        encoding='utf-8',
    )
    (server / 'eula.txt').write_text('eula=true\n', encoding='utf-8')
    (server / '.sgp-benchmark-server').write_text(
        'Generated by .github/scripts/prepare_bench.py; safe for benchmarks/bench.py to rebuild.\n',
        encoding='utf-8',
    )
    print(f'Prepared plugin-free benchmark server at {server}')


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('repository', type=Path)
    parser.add_argument('server', type=Path)
    args = parser.parse_args()
    prepare(args.repository, args.server)
