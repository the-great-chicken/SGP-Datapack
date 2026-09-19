"""PackTest metadata validation and generated test-environment resources."""
from __future__ import annotations

from dataclasses import dataclass
from pathlib import Path
import json
import re

MANIFEST = Path('tests/packtest_environments.json')
ENVIRONMENT_DIRECTIVE = re.compile(r'^# @environment\s+(\S+)\s*$', re.MULTILINE)
RESOURCE_ID = re.compile(r'^[a-z0-9_.-]+:[a-z0-9_./-]+$')


@dataclass(frozen=True)
class PackTestCase:
    path: Path
    resource: str
    environment: str | None


def _resource_path(data: Path, identifier: str, kind: str = 'function') -> Path:
    namespace, name = identifier.split(':', 1)
    suffix = '.mcfunction' if kind == 'function' else '.json'
    return data / namespace / kind / f'{name}{suffix}'


def _in_tree(identifier: str, tree: str) -> bool:
    return identifier == tree or identifier.startswith(tree + '/')


def discover_tests(repository: Path) -> list[PackTestCase]:
    """Discover PackTest functions from production namespaces and parse environments."""
    data = repository / 'data'
    tests = []
    for namespace in sorted(data.iterdir()):
        test_root = namespace / 'test'
        if not test_root.is_dir():
            continue
        for path in sorted(test_root.rglob('*.mcfunction')):
            relative = path.relative_to(test_root).with_suffix('').as_posix()
            resource = f'{namespace.name}:{relative}'
            matches = ENVIRONMENT_DIRECTIVE.findall(path.read_text(encoding='utf-8'))
            if len(matches) > 1:
                raise ValueError(f'{path}: multiple @environment directives')
            tests.append(PackTestCase(path, resource, matches[0] if matches else None))
    return tests


def load_environment_manifest(repository: Path) -> dict:
    path = repository / MANIFEST
    try:
        manifest = json.loads(path.read_text(encoding='utf-8'))
    except (OSError, ValueError, UnicodeError) as exc:
        raise ValueError(f'Invalid PackTest environment manifest {path}: {exc}') from exc
    unknown = set(manifest) - {'schema_version', 'groups', 'isolated_tests'}
    if unknown:
        raise ValueError(f'{path}: unsupported manifest fields: {sorted(unknown)}')
    if manifest.get('schema_version') != 1:
        raise ValueError(f'{path}: unsupported schema_version {manifest.get("schema_version")!r}')
    if not isinstance(manifest.get('groups'), list):
        raise ValueError(f'{path}: groups must be a list')
    if not isinstance(manifest.get('isolated_tests', []), list):
        raise ValueError(f'{path}: isolated_tests must be a list')
    return manifest


def _validate_definition(definition: object, context: str) -> dict:
    if not isinstance(definition, dict) or definition.get('type') != 'minecraft:function':
        raise ValueError(f'{context}: environment definition must have type minecraft:function')
    unknown = set(definition) - {'type', 'setup', 'teardown'}
    if unknown:
        raise ValueError(f'{context}: unsupported environment fields: {sorted(unknown)}')
    for key in ('setup', 'teardown'):
        value = definition.get(key)
        if value is not None and (not isinstance(value, str) or not RESOURCE_ID.fullmatch(value)):
            raise ValueError(f'{context}: invalid {key} function id {value!r}')
    return dict(definition)


def resolve_environment(manifest: dict, environment: str) -> dict:
    """Resolve one environment, allowing exact ids to override tree defaults."""
    if not RESOURCE_ID.fullmatch(environment):
        raise ValueError(f'Invalid PackTest environment id {environment!r}')

    exact = [group for group in manifest['groups'] if environment in group.get('ids', [])]
    if len(exact) > 1:
        raise ValueError(f'PackTest environment {environment} matches multiple exact definitions in {MANIFEST}')
    if exact:
        return _validate_definition(exact[0].get('definition'), environment)

    tree_matches = []
    for group in manifest['groups']:
        for tree in group.get('trees', []):
            if _in_tree(environment, tree):
                tree_matches.append((len(tree), group, tree))
    if not tree_matches:
        raise ValueError(f'PackTest environment {environment} has no definition in {MANIFEST}')
    specificity = max(length for length, _, _ in tree_matches)
    winners = [(group, tree) for length, group, tree in tree_matches if length == specificity]
    winner_groups = {id(group): group for group, _ in winners}
    if len(winner_groups) > 1:
        trees = sorted(tree for _, tree in winners)
        raise ValueError(f'PackTest environment {environment} matches equally specific trees {trees} in {MANIFEST}')
    group = next(iter(winner_groups.values()))
    return _validate_definition(group.get('definition'), environment)


def validate_repository(repository: Path) -> dict[str, dict]:
    """Validate PackTest metadata and return definitions for referenced environments."""
    repository = repository.resolve()
    manifest = load_environment_manifest(repository)
    tests = discover_tests(repository)
    referenced = {test.environment for test in tests if test.environment}

    fixture_data = repository / 'tests/fixtures/data'
    checked_in = sorted(
        path for path in fixture_data.rglob('*.json')
        if 'test_environment' in path.relative_to(fixture_data).parts
    ) if fixture_data.is_dir() else []
    if checked_in:
        sample = ', '.join(str(path.relative_to(repository)) for path in checked_in[:3])
        raise ValueError(
            f'PackTest environments are generated from {MANIFEST}; remove checked-in environment resources: {sample}'
        )

    # Validate every binding, not just bindings reached by the current tests. This
    # keeps stale exact ids and dead tree rules from accumulating in the catalog.
    for index, group in enumerate(manifest['groups']):
        if not isinstance(group, dict):
            raise ValueError(f'{MANIFEST}: group {index} must be an object')
        unknown = set(group) - {'ids', 'trees', 'definition'}
        if unknown:
            raise ValueError(f'{MANIFEST}: group {index} has unsupported fields: {sorted(unknown)}')
        ids = group.get('ids', [])
        trees = group.get('trees', [])
        if not isinstance(ids, list) or not isinstance(trees, list):
            raise ValueError(f'{MANIFEST}: group {index} ids/trees must be lists')
        if not ids and not trees:
            raise ValueError(f'{MANIFEST}: group {index} has no ids or trees')
        if len(ids) != len(set(ids)) or len(trees) != len(set(trees)):
            raise ValueError(f'{MANIFEST}: group {index} contains duplicate ids or trees')
        _validate_definition(group.get('definition'), f'{MANIFEST}: group {index}')
        for environment in ids + trees:
            if not isinstance(environment, str) or not RESOURCE_ID.fullmatch(environment):
                raise ValueError(f'{MANIFEST}: group {index} has invalid environment id {environment!r}')
        unused_ids = sorted(set(ids) - referenced)
        if unused_ids:
            raise ValueError(f'{MANIFEST}: unused exact environment ids: {unused_ids}')
        for tree in trees:
            if not any(_in_tree(environment, tree) for environment in referenced):
                raise ValueError(f'{MANIFEST}: unused environment tree {tree}')

    resolved = {environment: resolve_environment(manifest, environment) for environment in sorted(referenced)}

    for index, rule in enumerate(manifest.get('isolated_tests', [])):
        if not isinstance(rule, dict) or set(rule) != {'test_tree', 'environment_tree'}:
            raise ValueError(
                f'{MANIFEST}: isolated test rule {index} requires test_tree and environment_tree fields'
            )
        test_tree = rule['test_tree']
        environment_tree = rule['environment_tree']
        if not isinstance(test_tree, str) or not RESOURCE_ID.fullmatch(test_tree):
            raise ValueError(f'{MANIFEST}: isolated test rule {index} has invalid test_tree {test_tree!r}')
        if not isinstance(environment_tree, str) or not RESOURCE_ID.fullmatch(environment_tree):
            raise ValueError(
                f'{MANIFEST}: isolated test rule {index} has invalid environment_tree {environment_tree!r}'
            )
        matched = [test for test in tests if _in_tree(test.resource, test_tree)]
        if not matched:
            raise ValueError(f'{MANIFEST}: isolated test tree {test_tree!r} matches no tests')
        for test in matched:
            suffix = test.resource[len(test_tree):]
            expected = environment_tree + suffix
            if test.environment != expected:
                raise ValueError(
                    f'{test.path}: isolated test must use @environment {expected}, '
                    f'not {test.environment!r}'
                )

    return resolved


def materialize_environments(
    repository: Path, data: Path, environments: dict[str, dict] | None = None
) -> dict[str, dict]:
    """Write environment JSON for exactly the environment ids referenced by tests."""
    environments = environments if environments is not None else validate_repository(repository)
    targets = []
    for identifier, definition in environments.items():
        target = _resource_path(data, identifier, 'test_environment')
        if target.exists():
            raise ValueError(f'Generated PackTest environment would overwrite {target}')
        for field in ('setup', 'teardown'):
            function = definition.get(field)
            if function and not _resource_path(data, function).is_file():
                raise ValueError(f'{identifier}: {field} function does not exist: {function}')
        targets.append((target, definition))

    for target, definition in targets:
        target.parent.mkdir(parents=True, exist_ok=True)
        target.write_text(json.dumps(definition, separators=(',', ':')) + '\n', encoding='utf-8')
    print(f'Materialized {len(environments)} PackTest environments from {MANIFEST}.')
    return environments
