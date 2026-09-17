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


def load_scenarios(repository: Path):
    scenarios = {}
    for path in sorted((repository / 'benchmarks/scenarios').glob('*.json')):
        data = json.loads(path.read_text(encoding='utf-8'))
        required = {'name', 'description'}
        missing = required - data.keys()
        if missing:
            raise ValueError(f'{path}: missing keys {sorted(missing)}')
        name = data['name']
        if path.stem != name:
            raise ValueError(f'{path}: filename must match scenario name {name!r}')
        if name in scenarios:
            raise ValueError(f'{path}: duplicate scenario name {name!r}')
        atomic = all(key in data for key in ('setup', 'tick', 'teardown', 'parameters'))
        composite = 'components' in data
        if atomic == composite:
            raise ValueError(
                f'{path}: scenario must be exactly one of atomic '
                '(setup/tick/teardown/parameters) or composite (components)'
            )
        scenarios[name] = data
    if not scenarios:
        raise ValueError('No benchmark scenarios found')
    return scenarios


def function_file(data: Path, identifier: str):
    namespace, name = identifier.split(':', 1)
    return data / namespace / 'function' / f'{name}.mcfunction'


def validate_parameter_specs(scenario):
    params = scenario['parameters']
    if not isinstance(params, dict) or 'players' not in params:
        raise ValueError(f'Scenario {scenario["name"]}: parameters must include players')
    for name, spec in params.items():
        if not isinstance(spec, dict) or spec.get('type') != 'int':
            raise ValueError(f'Scenario {scenario["name"]}: only int parameters are supported ({name})')
        if not all(key in spec for key in ('min', 'max', 'default')):
            raise ValueError(f'Scenario {scenario["name"]}: incomplete parameter spec for {name}')
        if not spec['min'] <= spec['default'] <= spec['max']:
            raise ValueError(f'Scenario {scenario["name"]}: default for {name} is outside its range')


def validate_scenarios(data: Path, scenarios):
    for scenario in scenarios.values():
        if 'components' not in scenario:
            for key in ('setup', 'tick', 'teardown'):
                path = function_file(data, scenario[key])
                if not path.is_file():
                    raise ValueError(f'Scenario {scenario["name"]}: missing {key} function {scenario[key]}')
            validate_parameter_specs(scenario)
            continue

        components = scenario['components']
        if not isinstance(components, list) or not components:
            raise ValueError(f'Scenario {scenario["name"]}: components must be a non-empty list')
        for index, component in enumerate(components, 1):
            if not isinstance(component, dict) or 'scenario' not in component:
                raise ValueError(f'Scenario {scenario["name"]}: component {index} must reference a scenario')
            target = component['scenario']
            if target not in scenarios:
                raise ValueError(f'Scenario {scenario["name"]}: unknown component scenario {target!r}')
            if 'players' in component and (not isinstance(component['players'], int) or component['players'] < 0):
                raise ValueError(f'Scenario {scenario["name"]}: component {index} players must be >= 0')
            overrides = component.get('parameters', {})
            if not isinstance(overrides, dict) or any(not isinstance(value, int) for value in overrides.values()):
                raise ValueError(f'Scenario {scenario["name"]}: component {index} parameters must be integer values')

    def visit(name, stack):
        if name in stack:
            cycle = ' -> '.join((*stack, name))
            raise ValueError(f'Benchmark scenario composition cycle: {cycle}')
        scenario = scenarios[name]
        if 'components' not in scenario:
            return
        for component in scenario['components']:
            visit(component['scenario'], (*stack, name))

    for name in scenarios:
        visit(name, ())

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
