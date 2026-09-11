"""Offline checks for CI fixture isolation and dependency installation."""
from pathlib import Path
import gzip
import hashlib
import json
import re
import runpy
import struct
import tempfile
import unittest
import zipfile

SCRIPTS = Path(__file__).resolve().parent
PREPARE = runpy.run_path(str(SCRIPTS / 'prepare_core.py'))
MIXER = runpy.run_path(str(SCRIPTS / 'install_mixer.py'))
COVERAGE = runpy.run_path(str(SCRIPTS / 'datapack_coverage.py'))


class StagingTests(unittest.TestCase):
    def test_loot_table_is_preserved_and_fixture_is_deterministic(self):
        repo = SCRIPTS.parent.parent
        server = Path(tempfile.mkdtemp(prefix='sgp-ci-staging-test-')) / 'server'
        PREPARE['prepare'](repo, server)
        data = server / 'world/datapacks/SGP-Datapack/data'
        source = 'sgp.mineurs/loot_table/lootdrop_chest.json'
        preserved = PREPARE['FIXTURE_COLLISIONS'][source]
        self.assertEqual((data / preserved).read_bytes(), (repo / 'data' / source).read_bytes())
        self.assertEqual((data / source).read_bytes(), (repo / 'tests/fixtures/data' / source).read_bytes())

    def test_function_header_must_match_resource_id(self):
        root = Path(tempfile.mkdtemp(prefix='sgp-ci-header-test-')) / 'data'
        file = root / 'example/function/actual.mcfunction'
        file.parent.mkdir(parents=True)
        file.write_text('#> example:stale\nsay test\n')
        with self.assertRaisesRegex(ValueError, 'function header example:stale != example:actual'):
            PREPARE['validate'](root)

    def test_test_state_cannot_use_production_storage(self):
        root = Path(tempfile.mkdtemp(prefix='sgp-ci-storage-test-')) / 'data'
        file = root / 'sgp.ci/function/bad.mcfunction'
        file.parent.mkdir(parents=True)
        file.write_text('data modify storage sgp:data tests.bad set value {}\n')
        with self.assertRaisesRegex(ValueError, 'test-owned state must use sgp.ci storage'):
            PREPARE['validate'](root)

    def test_inline_sgp_storage_component_must_be_namespaced(self):
        root = Path(tempfile.mkdtemp(prefix='sgp-ci-text-storage-test-')) / 'data'
        file = root / 'example/function/bad.mcfunction'
        file.parent.mkdir(parents=True)
        file.write_text('tellraw @a {storage:"sgp.text",nbt:"prefix",interpret:true}\n')
        with self.assertRaisesRegex(ValueError, 'malformed SGP storage component id'):
            PREPARE['validate'](root)

    def test_data_remove_storage_requires_path(self):
        root = Path(tempfile.mkdtemp(prefix='sgp-ci-data-remove-test-')) / 'data'
        file = root / 'sgp.ci/function/bad.mcfunction'
        file.parent.mkdir(parents=True)
        file.write_text('data remove storage sgp.ci:stats\n')
        with self.assertRaisesRegex(ValueError, 'data remove storage requires an NBT path'):
            PREPARE['validate'](root)

    def test_dummy_spawn_name_must_fit_minecraft_username_rules(self):
        root = Path(tempfile.mkdtemp(prefix='sgp-ci-dummy-name-test-')) / 'data'
        file = root / 'sgp.ci/function/bad.mcfunction'
        file.parent.mkdir(parents=True)
        file.write_text('dummy ThisNameIsWayTooLong spawn\n')
        with self.assertRaisesRegex(ValueError, 'invalid dummy player name'):
            PREPARE['validate'](root)

    def test_unapproved_collision_fails_before_overwriting(self):
        root = Path(tempfile.mkdtemp(prefix='sgp-ci-collision-test-'))
        production, fixtures = root / 'production', root / 'fixtures'
        for directory, value in [(production, 'production'), (fixtures, 'fixture')]:
            file = directory / 'example/function/gameplay.mcfunction'
            file.parent.mkdir(parents=True)
            file.write_text(value)
        with self.assertRaisesRegex(ValueError, 'Unapproved fixture overrides'):
            PREPARE['overlay_fixtures'](production, fixtures)
        self.assertEqual((production / 'example/function/gameplay.mcfunction').read_text(), 'production')

    def test_mixer_keeps_sgp_override_and_both_load_hooks(self):
        root = Path(tempfile.mkdtemp(prefix='sgp-ci-mixer-test-'))
        pack = root / 'world/datapacks/SGP-Datapack'
        override = 'data/dah.actbar_mixer/function/z_private/display/self.mcfunction'
        hook = 'data/minecraft/tags/function/load.json'
        for path, text in [('pack.mcmeta', '{}'), (override, 'SGP override'),
                           (hook, json.dumps({'values': ['sgp:load']}))]:
            file = pack / path
            file.parent.mkdir(parents=True, exist_ok=True)
            file.write_text(text)
        archive = root / 'test-mixer.zip'
        with zipfile.ZipFile(archive, 'w') as output:
            output.writestr(override, 'Mixer base')
            output.writestr(hook, json.dumps({'values': ['mixer:load']}))
            output.writestr('data/mixer/function/register.mcfunction', 'say registered')
        install = MIXER['install']
        with self.assertRaisesRegex(ValueError, 'checksum mismatch'):
            install(root, archive)
        original_hash = install.__globals__['SHA256']
        try:
            install.__globals__['SHA256'] = hashlib.sha256(archive.read_bytes()).hexdigest()
            install(root, archive)
        finally:
            install.__globals__['SHA256'] = original_hash
        self.assertEqual((pack / override).read_text(), 'SGP override')
        self.assertEqual(json.loads((pack / hook).read_text())['values'], ['mixer:load', 'sgp:load'])
        self.assertEqual((pack / 'data/mixer/function/register.mcfunction').read_text(), 'say registered')


    def test_activation_items_have_batch_world_and_drop_isolation(self):
        repo = SCRIPTS.parent.parent
        tests = sorted((repo / 'data/sgp.kits/test/activation_items').glob('*.mcfunction'))
        self.assertEqual(
            [path.stem for path in tests],
            ['cooldown_stack', 'outside_arena', 'player_isolation', 'poseidon', 'whole_item'],
        )

        environments = []
        for path in tests:
            text = path.read_text(encoding='utf-8')
            match = re.search(r'^# @environment (\S+)$', text, re.MULTILINE)
            self.assertIsNotNone(match, path)
            expected = f'sgp.ci:activation_items/{path.stem}'
            self.assertEqual(match.group(1), expected)
            environments.append(match.group(1))
            self.assertIn('# @template sgp.ci:activation_items', text)

            env_file = (repo / 'tests/fixtures/data/sgp.ci/test_environment/activation_items'
                        / f'{path.stem}.json')
            self.assertTrue(env_file.is_file(), env_file)
            self.assertEqual(json.loads(env_file.read_text(encoding='utf-8')), {
                'type': 'minecraft:function',
                'setup': 'sgp.ci:players/cleanup',
                'teardown': 'sgp.ci:activation_items/cleanup',
            })

        self.assertEqual(len(environments), len(set(environments)))
        self.assertFalse((repo / 'tests/fixtures/data/sgp.ci/test_environment/activation_items.json').exists())

        tracker = (repo / 'tests/fixtures/data/sgp.ci/function/activation_items/track_drops.mcfunction').read_text(encoding='utf-8')
        owned = (repo / 'tests/fixtures/data/sgp.ci/function/activation_items/track_drop.mcfunction').read_text(encoding='utf-8')
        self.assertIn('execute as @a[tag=sgp.ci.activation_actor] at @s run function sgp.ci:activation_items/track_drop with entity @s', tracker)
        self.assertNotIn('tag @e[distance=..8,type=item]', tracker)
        self.assertIn('Thrower:$(UUID)', owned)
        self.assertIn('Age:0s', owned)
        self.assertIn('tag=!smithed.entity', owned)

        structure = repo / 'tests/fixtures/data/sgp.ci/structure/activation_items.nbt'
        raw = gzip.decompress(structure.read_bytes())
        self.assertTrue(raw.startswith(b'\x0a\x00\x00'))
        self.assertIn(b'\x03\x00\x0bDataVersion' + struct.pack('>i', 4790), raw)
        self.assertIn(b'\x09\x00\x04size\x03' + struct.pack('>i', 3)
                      + struct.pack('>iii', 9, 5, 5), raw)
        self.assertIn(b'minecraft:air', raw)
        self.assertIn(b'\x09\x00\x06blocks\x0a' + struct.pack('>i', 9 * 5 * 5), raw)

    def test_diorama_marker_tests_wait_for_owned_entities(self):
        repo = SCRIPTS.parent.parent
        owners = {
            'moved_model': {'id_a': 96004, 'id_b': 96005, 'y': '80.0'},
            'rectangular_dimensions': {'id_a': 96104, 'id_b': 96105, 'y': '96.0'},
            'matching_ids': {'id_a': 96204, 'id_b': 96205, 'y': '112.0'},
        }

        fixture = (repo / 'tests/fixtures/data/sgp.ci/function/diorama_markers/fixture.mcfunction').read_text(encoding='utf-8')
        ready = (repo / 'tests/fixtures/data/sgp.ci/function/diorama_markers/ready.mcfunction').read_text(encoding='utf-8')
        setup = (repo / 'tests/fixtures/data/sgp.ci/function/diorama_markers/setup.mcfunction').read_text(encoding='utf-8')
        link = (repo / 'tests/fixtures/data/sgp.ci/function/diorama_markers/link.mcfunction').read_text(encoding='utf-8')
        self.assertIn('sgp.ci.diorama_markers_$(owner)', fixture)
        self.assertIn('id:$(id_a)', fixture)
        self.assertIn('id:$(id_b)', fixture)
        self.assertNotIn('sgp.ci.diorama_lifecycle', fixture)
        self.assertIn('sgp.ci.diorama_markers_$(owner)', ready)
        self.assertNotIn('sgp.ci.origin_ready', ready)
        self.assertIn('forceload add 0 0 80 80', setup)
        self.assertNotIn('players/cleanup', setup)
        self.assertNotIn('diorama_lifecycle/cleanup', setup)
        self.assertEqual(link.count('tag=sgp.ci.diorama_markers_$(owner)'), 6)

        seen_ids = set()
        seen_y = set()
        roles = ('map_a', 'map_b', 'model_a', 'model_b')
        for owner, params in owners.items():
            test_file = repo / 'data/sgp.diorama/test/markers' / f'{owner}.mcfunction'
            text = test_file.read_text(encoding='utf-8')
            self.assertIn(f'# @environment sgp.ci:diorama_markers/{owner}', text)
            self.assertIn(f'function sgp.ci:diorama_markers/ready {{owner:"{owner}"}}', text)
            self.assertNotIn('sgp.ci:origin_arena/ready', text)
            self.assertNotIn('sgp.ci.origin_ready', text)

            fixture_call = (f'function sgp.ci:diorama_markers/fixture '
                            f'{{owner:"{owner}",id_a:{params["id_a"]},id_b:{params["id_b"]},y:{params["y"]}}}')
            link_call = f'function sgp.ci:diorama_markers/link {{owner:"{owner}"}}'
            self.assertIn(fixture_call, text)
            self.assertIn(link_call, text)
            fixture_at = text.index(fixture_call)
            link_at = text.index(link_call, fixture_at)
            for role in roles:
                wait = (f'await entity @e[tag=sgp.ci.diorama_markers_{owner},'
                        f'tag=sgp.ci.markers_{role},type=marker]')
                self.assertIn(wait, text[fixture_at:link_at])

            env_file = (repo / 'tests/fixtures/data/sgp.ci/test_environment/diorama_markers'
                        / f'{owner}.json')
            self.assertEqual(json.loads(env_file.read_text(encoding='utf-8')), {
                'type': 'minecraft:function',
                'setup': 'sgp.ci:diorama_markers/setup',
                'teardown': f'sgp.ci:diorama_markers/cleanup_{owner}',
            })
            cleanup = (repo / 'tests/fixtures/data/sgp.ci/function/diorama_markers'
                       / f'cleanup_{owner}.mcfunction').read_text(encoding='utf-8')
            self.assertIn(f'kill @e[tag=sgp.ci.diorama_markers_{owner},type=marker]', cleanup)
            self.assertNotIn('sgp.ci.diorama_lifecycle', cleanup)
            self.assertNotIn('sgp.ci.origin_ready', cleanup)
            self.assertNotIn('players/cleanup', cleanup)

            self.assertTrue(seen_ids.isdisjoint({params['id_a'], params['id_b']}))
            seen_ids.update({params['id_a'], params['id_b']})
            self.assertNotIn(params['y'], seen_y)
            seen_y.add(params['y'])

    def test_spawn_routing_tests_do_not_share_global_routing_state(self):
        repo = SCRIPTS.parent.parent
        tests = sorted((repo / 'data/sgp.misc/test/spawn_routing').glob('*.mcfunction'))
        self.assertGreaterEqual(len(tests), 5)
        environments = []
        for path in tests:
            text = path.read_text(encoding='utf-8')
            match = re.search(r'^# @environment (\S+)$', text, re.MULTILINE)
            self.assertIsNotNone(match, path)
            expected = f'sgp.ci:spawn_routing/{path.stem}'
            self.assertEqual(match.group(1), expected)
            environments.append(expected)
            env_file = repo / 'tests/fixtures/data/sgp.ci/test_environment/spawn_routing' / f'{path.stem}.json'
            self.assertEqual(json.loads(env_file.read_text(encoding='utf-8')), {
                'type': 'minecraft:function',
                'setup': 'sgp.ci:spawn_routing/setup',
                'teardown': 'sgp.ci:spawn_routing/cleanup',
            })
        self.assertEqual(len(environments), len(set(environments)))
        self.assertFalse((repo / 'tests/fixtures/data/sgp.ci/test_environment/spawn_routing.json').exists())

    def test_protection_fixture_restores_health_after_login_wait(self):
        repo = SCRIPTS.parent.parent
        prepare = (repo / 'tests/fixtures/data/sgp.ci/function/protection/prepare.mcfunction').read_text(encoding='utf-8')
        self.assertIn('effect give @s minecraft:instant_health 1 4 true', prepare)
        self.assertIn('effect give ProtectPeer minecraft:instant_health 1 4 true', prepare)
        self.assertLess(prepare.index('effect give @s minecraft:instant_health'),
                        prepare.index('assert entity @s[nbt={Health:20.0f}]'))

    def test_mixer_uid_waits_require_fresh_uuid_registration(self):
        repo = SCRIPTS.parent.parent
        fresh_call = 'function sgp.ci:actionbar_mixer/fresh_registration'
        uid_wait = 'await score @s dah.actbar.UID matches 1..'
        wait_files = []
        for path in sorted((repo / 'data').rglob('*.mcfunction')):
            text = path.read_text(encoding='utf-8')
            if uid_wait not in text:
                continue
            wait_files.append(path)
            self.assertIn(fresh_call, text[:text.index(uid_wait)], path)
        self.assertEqual(len(wait_files), 7)

        peer = (repo / 'data/sgp.misc/test/reward_hud/player_isolation.mcfunction').read_text(encoding='utf-8')
        peer_wait = 'await score RewardPeer dah.actbar.UID matches 1..'
        peer_fresh = 'execute as RewardPeer run function sgp.ci:actionbar_mixer/fresh_registration'
        self.assertIn(peer_fresh, peer[:peer.index(peer_wait)])

        helper = (repo / 'tests/fixtures/data/sgp.ci/function/actionbar_mixer/fresh_registration.mcfunction').read_text(encoding='utf-8')
        remover = (repo / 'tests/fixtures/data/sgp.ci/function/actionbar_mixer/remove_uid.mcfunction').read_text(encoding='utf-8')
        self.assertIn('store result storage sgp.ci:actionbar_mixer stale_uid int 1', helper)
        self.assertIn('scoreboard players reset @s dah.actbar.UID', helper)
        self.assertIn('advancement revoke @s only dah.actbar_mixer:new_player', helper)
        self.assertIn('$data remove storage dah:actbar data[{UID:$(stale_uid)}]', remover)


    def test_datapack_coverage_instruments_only_staged_production_functions(self):
        root = Path(tempfile.mkdtemp(prefix='sgp-ci-coverage-test-'))
        repo = root / 'repo'
        server = root / 'server'
        source_data = repo / 'data'
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
        COVERAGE['instrument'](repo, server)

        mapping = json.loads((server / COVERAGE['MAP_NAME']).read_text(encoding='utf-8'))
        self.assertEqual([entry['resource'] for entry in mapping['functions']],
                         ['example:alpha', 'example:nested/beta'])
        self.assertEqual(mapping['tests_per_namespace']['example'], 1)
        self.assertEqual((source_data / 'example/function/alpha.mcfunction').read_text(encoding='utf-8'),
                         'say alpha\n')
        self.assertIn('SGP_COVERAGE:000001',
                      (staged_data / 'example/function/alpha.mcfunction').read_text(encoding='utf-8'))
        self.assertIn('SGP_COVERAGE:000002',
                      (staged_data / 'example/function/nested/beta.mcfunction').read_text(encoding='utf-8'))
        self.assertNotIn('SGP_COVERAGE', fixture.read_text(encoding='utf-8'))
        alpha = (staged_data / 'example/function/alpha.mcfunction').read_text(encoding='utf-8')
        self.assertIn('execute unless data storage sgp.ci:coverage c000001', alpha)
        self.assertIn('data modify storage sgp.ci:coverage c000001 set value 1b', alpha)

    def test_datapack_coverage_reports_metrics_per_namespace(self):
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
        report = COVERAGE['build_report'](mapping, {'000001', '000003'})
        self.assertEqual(report['namespaces']['alpha'], {
            'tests': 3, 'functions_hit': 1, 'functions_total': 2, 'coverage_percent': 50.0,
        })
        self.assertEqual(report['namespaces']['beta'], {
            'tests': 2, 'functions_hit': 1, 'functions_total': 1, 'coverage_percent': 100.0,
        })
        self.assertEqual(report['total'], {
            'tests': 5, 'functions_hit': 2, 'functions_total': 3, 'coverage_percent': 66.7,
        })
        markdown = COVERAGE['render_markdown'](report)
        self.assertIn('| `alpha` | 3 | 1 | 2 | 50.0% |', markdown)
        self.assertIn('| `beta` | 2 | 1 | 1 | 100.0% |', markdown)
        self.assertEqual(report['uncovered_functions'], ['alpha:b'])


if __name__ == '__main__':
    unittest.main()
