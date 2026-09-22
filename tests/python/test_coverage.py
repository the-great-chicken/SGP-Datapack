import json

from common import RepositoryTestCase
from sgp_tools import coverage


class CoverageTests(RepositoryTestCase):
    def test_instrument_only_touches_staged_production_functions(self):
        root = self.temporary_path()
        repository = root / 'repo'
        server = root / 'server'
        source_data = repository / 'data'
        staged_data = server / 'world/datapacks/SGP-Datapack/data'

        files = {
            'example/function/alpha.mcfunction': 'say alpha\n',
            'example/function/nested/beta.mcfunction': '$say $(message)\n',
            'example/test/alpha.mcfunction': 'assert entity @s\n',
            'sgp.integration.tab/function/only_in_full_pack.mcfunction': 'say integration\n',
        }
        for relative, content in files.items():
            path = source_data / relative
            path.parent.mkdir(parents=True, exist_ok=True)
            path.write_text(content, encoding='utf-8')
        for relative in ('example/function/alpha.mcfunction', 'example/function/nested/beta.mcfunction'):
            source = source_data / relative
            target = staged_data / relative
            target.parent.mkdir(parents=True, exist_ok=True)
            target.write_text(source.read_text(encoding='utf-8'), encoding='utf-8')
        fixture = staged_data / 'sgp.ci/function/helper.mcfunction'
        fixture.parent.mkdir(parents=True, exist_ok=True)
        fixture.write_text('say fixture\n', encoding='utf-8')

        coverage.instrument(repository, server)

        mapping = json.loads((server / coverage.MAP_NAME).read_text(encoding='utf-8'))
        self.assertEqual([entry['resource'] for entry in mapping['functions']], ['example:alpha', 'example:nested/beta'])
        self.assertEqual(mapping['tests_per_namespace']['example'], 1)
        self.assertEqual((source_data / 'example/function/alpha.mcfunction').read_text(encoding='utf-8'), 'say alpha\n')
        self.assertIn('SGP_COVERAGE:000001', (staged_data / 'example/function/alpha.mcfunction').read_text(encoding='utf-8'))
        self.assertIn('SGP_COVERAGE:000002', (staged_data / 'example/function/nested/beta.mcfunction').read_text(encoding='utf-8'))
        self.assertNotIn('SGP_COVERAGE', fixture.read_text(encoding='utf-8'))

    def test_report_metrics_are_derived_from_mapping_and_hits(self):
        mapping = {
            'schema_version': 1,
            'metric': 'function_hit',
            'tests_per_namespace': {'alpha': 3, 'beta': 2},
            'functions': [
                {'id': '000001', 'namespace': 'alpha', 'resource': 'alpha:a', 'path': 'data/alpha/function/a.mcfunction'},
                {'id': '000002', 'namespace': 'alpha', 'resource': 'alpha:b', 'path': 'data/alpha/function/b.mcfunction'},
                {'id': '000003', 'namespace': 'beta', 'resource': 'beta:c', 'path': 'data/beta/function/c.mcfunction'},
            ],
        }
        report = coverage.build_report(mapping, {'000001', '000003'})
        self.assertEqual(report['namespaces']['alpha'], {
            'tests': 3, 'functions_hit': 1, 'functions_total': 2, 'coverage_percent': 50.0,
        })
        self.assertEqual(report['namespaces']['beta'], {
            'tests': 2, 'functions_hit': 1, 'functions_total': 1, 'coverage_percent': 100.0,
        })
        self.assertEqual(report['total'], {
            'tests': 5, 'functions_hit': 2, 'functions_total': 3, 'coverage_percent': 66.7,
        })
        self.assertEqual(report['uncovered_functions'], ['alpha:b'])
        markdown = coverage.render_markdown(report)
        self.assertIn('| `alpha` | 3 | 1 | 2 | 50.0% |', markdown)
        self.assertIn('| `beta` | 2 | 1 | 1 | 100.0% |', markdown)
