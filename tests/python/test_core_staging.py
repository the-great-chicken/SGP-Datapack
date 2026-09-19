import json

from common import ROOT, RepositoryTestCase
from sgp_tools import core_staging
from sgp_tools import packtest


class CoreStagingTests(RepositoryTestCase):
    def test_loot_table_is_preserved_and_fixture_is_deterministic(self):
        server = self.temporary_path('sgp-ci-test-') / 'server'
        core_staging.prepare(ROOT, server)
        data = server / 'world/datapacks/SGP-Datapack/data'
        source = 'sgp.mineurs/loot_table/lootdrop_chest.json'
        preserved = core_staging.FIXTURE_COLLISIONS[source]
        self.assertEqual((data / preserved).read_bytes(), (ROOT / 'data' / source).read_bytes())
        self.assertEqual((data / source).read_bytes(), (ROOT / 'tests/fixtures/data' / source).read_bytes())

        resolved = packtest.validate_repository(ROOT)
        staged = sorted((data / 'sgp.ci/test_environment').rglob('*.json'))
        self.assertEqual(len(staged), len(resolved))
        for identifier, definition in resolved.items():
            _, name = identifier.split(':', 1)
            path = data / 'sgp.ci/test_environment' / f'{name}.json'
            self.assertEqual(json.loads(path.read_text(encoding='utf-8')), definition)

    def test_function_header_must_match_resource_id(self):
        root = self.temporary_path() / 'data'
        file = root / 'example/function/actual.mcfunction'
        file.parent.mkdir(parents=True)
        file.write_text('#> example:stale\nsay test\n')
        with self.assertRaisesRegex(ValueError, 'function header example:stale != example:actual'):
            core_staging.validate(root)

    def test_test_state_cannot_use_production_storage(self):
        root = self.temporary_path() / 'data'
        file = root / 'sgp.ci/function/bad.mcfunction'
        file.parent.mkdir(parents=True)
        file.write_text('data modify storage sgp:data tests.bad set value {}\n')
        with self.assertRaisesRegex(ValueError, 'test-owned state must use sgp.ci storage'):
            core_staging.validate(root)

    def test_inline_sgp_storage_component_must_be_namespaced(self):
        root = self.temporary_path() / 'data'
        file = root / 'example/function/bad.mcfunction'
        file.parent.mkdir(parents=True)
        file.write_text('tellraw @a {storage:"sgp.text",nbt:"prefix",interpret:true}\n')
        with self.assertRaisesRegex(ValueError, 'malformed SGP storage component id'):
            core_staging.validate(root)

    def test_data_remove_storage_requires_path(self):
        root = self.temporary_path() / 'data'
        file = root / 'sgp.ci/function/bad.mcfunction'
        file.parent.mkdir(parents=True)
        file.write_text('data remove storage sgp.ci:stats\n')
        with self.assertRaisesRegex(ValueError, 'data remove storage requires an NBT path'):
            core_staging.validate(root)

    def test_dummy_spawn_name_must_fit_minecraft_username_rules(self):
        root = self.temporary_path() / 'data'
        file = root / 'sgp.ci/function/bad.mcfunction'
        file.parent.mkdir(parents=True)
        file.write_text('dummy ThisNameIsWayTooLong spawn\n')
        with self.assertRaisesRegex(ValueError, 'invalid dummy player name'):
            core_staging.validate(root)

    def test_unapproved_collision_fails_before_overwriting(self):
        root = self.temporary_path()
        production, fixtures = root / 'production', root / 'fixtures'
        for directory, value in [(production, 'production'), (fixtures, 'fixture')]:
            file = directory / 'example/function/gameplay.mcfunction'
            file.parent.mkdir(parents=True)
            file.write_text(value)
        with self.assertRaisesRegex(ValueError, 'Unapproved fixture overrides'):
            core_staging.overlay_fixtures(production, fixtures)
        self.assertEqual((production / 'example/function/gameplay.mcfunction').read_text(), 'production')
