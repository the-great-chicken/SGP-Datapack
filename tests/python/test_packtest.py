import json

from common import ROOT, RepositoryTestCase
from sgp_tools import packtest


class PackTestHarnessTests(RepositoryTestCase):
    def write_manifest(self, repository, *, groups, isolated_tests=None):
        path = repository / packtest.MANIFEST
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text(json.dumps({
            'schema_version': 1,
            'groups': groups,
            'isolated_tests': isolated_tests or [],
        }), encoding='utf-8')

    def write_test(self, repository, resource, environment):
        namespace, name = resource.split(':', 1)
        path = repository / 'data' / namespace / 'test' / f'{name}.mcfunction'
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text(f'# @environment {environment}\nassert entity @s\n', encoding='utf-8')
        return path

    def test_repository_catalog_resolves_every_environment_annotation(self):
        resolved = packtest.validate_repository(ROOT)
        referenced = {
            test.environment
            for test in packtest.discover_tests(ROOT)
            if test.environment
        }
        self.assertEqual(set(resolved), referenced)
        self.assertFalse(any((ROOT / 'tests/fixtures/data').glob('*/test_environment/**/*.json')))

    def test_tree_binding_scales_to_new_tests_without_new_resource_files(self):
        repository = self.temporary_path()
        self.write_test(repository, 'example:feature/new_case', 'sgp.ci:feature/new_case')
        definition = {
            'type': 'minecraft:function',
            'setup': 'sgp.ci:feature/setup',
            'teardown': 'sgp.ci:feature/cleanup',
        }
        self.write_manifest(repository, groups=[{
            'trees': ['sgp.ci:feature'],
            'definition': definition,
        }])
        self.assertEqual(packtest.validate_repository(repository), {
            'sgp.ci:feature/new_case': definition,
        })

    def test_isolation_rule_rejects_a_shared_environment(self):
        repository = self.temporary_path()
        path = self.write_test(repository, 'example:feature/first', 'sgp.ci:feature/shared')
        self.write_manifest(
            repository,
            groups=[{
                'trees': ['sgp.ci:feature'],
                'definition': {'type': 'minecraft:function'},
            }],
            isolated_tests=[{
                'test_tree': 'example:feature',
                'environment_tree': 'sgp.ci:feature',
            }],
        )
        with self.assertRaisesRegex(ValueError, 'isolated test must use @environment sgp.ci:feature/first'):
            packtest.validate_repository(repository)
        self.assertTrue(path.is_file())

    def test_exact_environment_binding_overrides_a_tree_default(self):
        repository = self.temporary_path()
        self.write_test(repository, 'example:feature/case', 'sgp.ci:feature/case')
        default = {'type': 'minecraft:function'}
        exception = {'type': 'minecraft:function', 'teardown': 'sgp.ci:feature/cleanup'}
        self.write_manifest(repository, groups=[
            {'trees': ['sgp.ci:feature'], 'definition': default},
            {'ids': ['sgp.ci:feature/case'], 'definition': exception},
        ])
        self.assertEqual(packtest.validate_repository(repository), {
            'sgp.ci:feature/case': exception,
        })

    def test_more_specific_environment_tree_overrides_a_parent_tree(self):
        repository = self.temporary_path()
        self.write_test(repository, 'example:feature/special/case', 'sgp.ci:feature/special/case')
        default = {'type': 'minecraft:function'}
        special = {'type': 'minecraft:function', 'teardown': 'sgp.ci:feature/cleanup'}
        self.write_manifest(repository, groups=[
            {'trees': ['sgp.ci:feature'], 'definition': default},
            {'trees': ['sgp.ci:feature/special'], 'definition': special},
        ])
        self.assertEqual(packtest.validate_repository(repository), {
            'sgp.ci:feature/special/case': special,
        })

    def test_equally_specific_environment_trees_are_rejected(self):
        repository = self.temporary_path()
        self.write_test(repository, 'example:feature/case', 'sgp.ci:feature/case')
        definition = {'type': 'minecraft:function'}
        self.write_manifest(repository, groups=[
            {'trees': ['sgp.ci:feature'], 'definition': definition},
            {'trees': ['sgp.ci:feature'], 'definition': definition},
        ])
        with self.assertRaisesRegex(ValueError, 'matches equally specific trees'):
            packtest.validate_repository(repository)

    def test_manifest_rejects_unknown_group_fields(self):
        repository = self.temporary_path()
        self.write_test(repository, 'example:feature/case', 'sgp.ci:feature/case')
        self.write_manifest(repository, groups=[{
            'trees': ['sgp.ci:feature'],
            'defintion': {'type': 'minecraft:function'},
        }])
        with self.assertRaisesRegex(ValueError, 'unsupported fields'):
            packtest.validate_repository(repository)

    def test_materialization_requires_real_setup_and_teardown_functions(self):
        repository = self.temporary_path()
        data = repository / 'staged/data'
        self.write_test(repository, 'example:feature/case', 'sgp.ci:feature/case')
        self.write_manifest(repository, groups=[{
            'trees': ['sgp.ci:feature'],
            'definition': {
                'type': 'minecraft:function',
                'setup': 'sgp.ci:feature/setup',
            },
        }])
        with self.assertRaisesRegex(ValueError, 'setup function does not exist'):
            packtest.materialize_environments(repository, data)
