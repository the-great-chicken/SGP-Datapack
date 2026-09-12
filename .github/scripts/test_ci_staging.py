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


    def test_loadout_contracts_cover_every_kit_collection(self):
        repo = SCRIPTS.parent.parent
        collection = repo / 'data/sgp.kits/function/collection'
        expected = sorted(path.name for path in collection.iterdir()
                          if path.is_dir() and (path / 'items.mcfunction').is_file()
                          and (path / 'specifics.mcfunction').is_file())
        tests = sorted((repo / 'data/sgp.kits/test/loadouts').glob('*.mcfunction'))
        self.assertEqual([path.stem for path in tests], expected)

        for path in tests:
            kit = path.stem
            text = path.read_text(encoding='utf-8')
            self.assertIn('# @dummy', text, path)
            self.assertIn(f'function sgp.kits:give {{kit:"{kit}"}}', text, path)
            self.assertIn('assert score @s sgp.reset_tags matches 1', text, path)
            self.assertIn(f'assert entity @s[tag=sgp.{kit}_voulu', text, path)
            assertion_count = text.count('function sgp.ci:loadouts/expect_') + text.count('function sgp.ci:inventory/expect_count')
            self.assertGreaterEqual(assertion_count, 2, path)
            # Default amplifier 0 is omitted from serialized active_effects NBT in the
            # PackTest runtime; asserting amplifier:0b creates a false negative.
            self.assertNotIn('amplifier:0b', text, path)

        slot_helper = (repo / 'tests/fixtures/data/sgp.ci/function/loadouts/expect_slot.mcfunction').read_text(encoding='utf-8')
        enchantment_helper = (repo / 'tests/fixtures/data/sgp.ci/function/loadouts/expect_enchantment.mcfunction').read_text(encoding='utf-8')
        enchantment_count = (repo / 'tests/fixtures/data/sgp.ci/function/loadouts/expect_enchantment_count.mcfunction').read_text(encoding='utf-8')
        self.assertIn('if items entity @s $(slot) $(item)', slot_helper)
        self.assertIn('if items entity @s $(slot) $(item)[enchantments~', enchantment_helper)
        self.assertIn('run clear @s $(item)[enchantments~', enchantment_count)

    def test_stats_collector_entrypoints_exercise_public_boundaries(self):
        repo = SCRIPTS.parent.parent
        tests = repo / 'data/sgp.kits/test/stats_collector/entrypoints'
        expected = {
            'ability_lifecycle': [
                'function sgp.kits:stats_collector/ability/start',
                'function sgp.kits:stats_collector/ability/mark_affected',
                'function sgp.kits:stats_collector/ability/mark_success',
                'function sgp.kits:stats_collector/ability/tank_hit',
            ],
            'kill_attribution': ['function sgp.kits:stats_collector/collect_kill_infos'],
            'kit_pick': ['function sgp.kits:stats_collector/collect_kit_pick_infos'],
            'death_position': ['function sgp.kits:stats_collector/death_position/capture'],
            'elo_real_death': ['function sgp.kits:stats_collector/elo/on_real_death'],
        }
        self.assertEqual({path.stem for path in tests.glob('*.mcfunction')}, set(expected))
        for name, calls in expected.items():
            text = (tests / f'{name}.mcfunction').read_text(encoding='utf-8')
            for call in calls:
                self.assertIn(call, text)
            # These are integration contracts: they must not substitute the lower-level
            # storage helper for the public event function being exercised.
            if name == 'kill_attribution':
                self.assertNotIn('function sgp.kits:stats_collector/save_kill_cause_stat', text)
                self.assertIn('gamemode creative @s', text)
                self.assertIn('dummy StatsVictim spawn', text)
                self.assertIn('gamemode creative StatsVictim', text)
                self.assertIn('gamemode survival StatsVictim', text)
                self.assertIn('await delay 61t', text)
                self.assertIn('effect give StatsVictim minecraft:instant_health 1 4 true', text)
                self.assertNotIn('nbt={Health:', text)
                self.assertIn('damage StatsVictim 1 minecraft:player_attack by @s', text)
                self.assertLess(text.index('await delay 61t'), text.index('damage StatsVictim 1 minecraft:player_attack by @s'))
                self.assertIn('execute as StatsVictim on attacker run tag @s add sgp.ci.stats_kill_attacker', text)
                self.assertIn('assert entity @s[tag=sgp.ci.stats_kill_attacker]', text)
                self.assertIn('scoreboard players set StatsVictim sgp.death_cause 100', text)
                self.assertLess(text.index('damage StatsVictim 1 minecraft:player_attack by @s'),
                                text.index('scoreboard players set StatsVictim sgp.death_cause 100'))
                self.assertLess(text.index('scoreboard players set StatsVictim sgp.death_cause 100'),
                                text.index('execute as StatsVictim run function sgp.kits:stats_collector/collect_kill_infos'))
                self.assertIn('execute as StatsVictim run function sgp.kits:stats_collector/collect_kill_infos', text)
            if name == 'kit_pick':
                self.assertNotIn('function sgp.kits:stats_collector/save_pick_start', text)
            if name == 'death_position':
                self.assertNotIn('function sgp.kits:stats_collector/death_position/save', text)
            if name == 'elo_real_death':
                self.assertIn('gamemode creative @s', text)
                self.assertIn('dummy StatsEloV spawn', text)
                self.assertIn('gamemode creative StatsEloV', text)
                self.assertIn('gamemode survival StatsEloV', text)
                self.assertIn('await delay 61t', text)
                self.assertIn('effect give StatsEloV minecraft:instant_health 1 4 true', text)
                self.assertNotIn('nbt={Health:', text)
                self.assertIn('damage StatsEloV 1 minecraft:player_attack by @s', text)
                self.assertLess(text.index('await delay 61t'), text.index('damage StatsEloV 1 minecraft:player_attack by @s'))
                self.assertIn('execute as StatsEloV on attacker run tag @s add sgp.ci.stats_elo_attacker', text)
                self.assertIn('assert entity @s[tag=sgp.ci.stats_elo_attacker]', text)
                self.assertIn('execute as StatsEloV run function sgp.kits:stats_collector/elo/on_real_death', text)

            if name != 'death_position':
                env = re.search(r'^# @environment (\S+)$', text, re.MULTILINE)
                self.assertIsNotNone(env, name)
                self.assertEqual(env.group(1), f'sgp.ci:stats_collector_guarded/entrypoints/{name}')
                env_file = (repo / 'tests/fixtures/data/sgp.ci/test_environment/stats_collector_guarded/entrypoints'
                            / f'{name}.json')
                self.assertEqual(json.loads(env_file.read_text(encoding='utf-8')), {
                    'type': 'minecraft:function',
                    'setup': 'sgp.ci:stats_collector/guarded_setup',
                    'teardown': 'sgp.ci:stats_collector/guarded_teardown',
                })

    def test_death_cause_contract_is_exhaustive_and_unambiguous(self):
        repo = SCRIPTS.parent.parent
        functions = repo / 'data/sgp.kits/function/stats_collector/death_cause'
        advancements = repo / 'data/sgp.kits/advancement/death_cause'
        tags = repo / 'data/sgp.kits/tags/damage_type/death_cause'

        function_ids = {}
        for path in sorted(functions.glob('*.mcfunction')):
            text = path.read_text(encoding='utf-8')
            match = re.search(r'scoreboard players set @s sgp\.death_cause (-?\d+)', text)
            self.assertIsNotNone(match, path)
            function_ids[path.stem] = int(match.group(1))
            self.assertIn('function sgp.kits:stats_collector/collect_damage_received', text, path)

        init = (repo / 'data/sgp.kits/function/stats_collector/init.mcfunction').read_text(encoding='utf-8')
        match = re.search(r'damage_cause_names set value (\{[^\n]+\})', init)
        self.assertIsNotNone(match)
        metadata = {name: int(cause_id) for cause_id, name in json.loads(match.group(1)).items()}
        self.assertEqual(function_ids, metadata)
        self.assertEqual(sorted(cause_id for cause_id in function_ids.values() if cause_id < 100), list(range(29)))
        self.assertEqual(sorted(cause_id for cause_id in function_ids.values() if cause_id >= 100), [100, 101, 102])

        concrete_members = {}
        for name in sorted(function_ids):
            advancement = json.loads((advancements / f'{name}.json').read_text(encoding='utf-8'))
            self.assertEqual(advancement['rewards']['function'],
                             f'sgp.kits:stats_collector/death_cause/{name}')
            condition = advancement['criteria']['track']['conditions']['damage']['type']['tags']
            if name == 'unknown':
                self.assertEqual(condition, [{'id': 'sgp.kits:death_cause/known', 'expected': False}])
                continue
            self.assertEqual(condition, [{'id': f'sgp.kits:death_cause/{name}', 'expected': True}])
            tag = json.loads((tags / f'{name}.json').read_text(encoding='utf-8'))
            for value in tag['values']:
                if value.startswith('#'):
                    continue
                self.assertNotIn(value, concrete_members,
                                 f'{value} classified by both {concrete_members.get(value)} and {name}')
                concrete_members[value] = name

        known = json.loads((tags / 'known.json').read_text(encoding='utf-8'))['values']
        expected_known = {f'#sgp.kits:death_cause/{name}' for name in function_ids if name != 'unknown'}
        self.assertEqual(set(known), expected_known)
        self.assertEqual(len(known), len(expected_known))

        runtime_tests = sorted((repo / 'data/sgp.kits/test/stats_collector/death_cause').glob('*.mcfunction'))
        combined = '\n'.join(path.read_text(encoding='utf-8') for path in runtime_tests)
        for name, cause_id in function_ids.items():
            self.assertIn(f'function sgp.ci:death_cause/expect {{cause:"{name}",id:{cause_id}}}', combined)

    def test_bats_empty_slots_are_guarded_before_component_mutation(self):
        repo = SCRIPTS.parent.parent
        held = repo / 'data/sgp.kits/function/abilities/bats/hide/held_item.mcfunction'
        text = held.read_text(encoding='utf-8')
        copied = '$item replace entity @s weapon.mainhand from entity @p[tag=sgp.processing] $(slot)'
        guard = 'execute unless data entity @s equipment.mainhand.id run return 0'
        self.assertIn(copied, text)
        self.assertIn(guard, text)
        self.assertLess(text.index(copied), text.index(guard))
        self.assertGreater(text.find('equipment.mainhand.components'), text.index(guard))

        armor = repo / 'data/sgp.kits/function/abilities/bats/hide/armor_item.mcfunction'
        text = armor.read_text(encoding='utf-8')
        copied = '$item replace entity @s armor.$(slot) from entity @p[tag=sgp.processing] armor.$(slot)'
        guard = '$execute unless data entity @s equipment.$(slot).id run return 0'
        self.assertIn(copied, text)
        self.assertIn(guard, text)
        self.assertLess(text.index(copied), text.index(guard))
        self.assertGreater(text.find('equipment.$(slot).components'), text.index(guard))

        equipment = (repo / 'data/sgp.kits/function/abilities/bats/hide/equipment.mcfunction').read_text(encoding='utf-8')
        head_mutations = [line.strip() for line in equipment.splitlines()
                          if 'equipment.head.components' in line]
        self.assertTrue(head_mutations)
        self.assertTrue(all(line.startswith('execute if data entity @s equipment.head.id run ')
                            for line in head_mutations))

        restore = (repo / 'data/sgp.kits/function/abilities/bats/restore/held_item.mcfunction').read_text(encoding='utf-8')
        self.assertIn('execute unless data entity @s equipment.mainhand.id run return 0', restore)

    def test_diorama_cleanup_waits_out_mannequin_dying_pose(self):
        repo = SCRIPTS.parent.parent
        retire = (repo / 'tests/fixtures/data/sgp.ci/function/diorama_cleanup/retire.mcfunction').read_text(encoding='utf-8')
        self.assertIn('kill @e[tag=sgp.ci.removal,type=mannequin]', retire)
        self.assertIn('tp @e[tag=sgp.ci.removal,type=mannequin] ~ ~-1000 ~', retire)
        for name in ('death_cleanup', 'leave_giant', 'leave_small'):
            path = repo / 'data/sgp.diorama/test/cleanup' / f'{name}.mcfunction'
            text = path.read_text(encoding='utf-8')
            retire_call = 'function sgp.ci:diorama_cleanup/retire'
            grace = 'await delay 21t'
            gone = 'assert not entity @e[tag=sgp.ci.removal,type=mannequin]'
            self.assertIn(retire_call, text, path)
            self.assertIn(grace, text, path)
            self.assertIn(gone, text, path)
            self.assertLess(text.index(retire_call), text.index(grace), path)
            self.assertLess(text.index(grace), text.index(gone), path)
            self.assertNotIn('await not entity @e[tag=sgp.ci.removal,type=mannequin]', text, path)

    def test_kill_effect_no_attacker_avoids_loading_grace_exposure(self):
        repo = SCRIPTS.parent.parent
        path = repo / 'data/sgp.cosmetics/test/kill_effects/no_attacker.mcfunction'
        text = path.read_text(encoding='utf-8')
        self.assertIn('function sgp.ci:kill_effects/prepare', text)
        self.assertNotIn('await delay 61t', text)
        self.assertNotIn('function sgp.ci:kill_effects/record_attacker', text)

    def test_ability_entrypoint_tests_use_public_router_and_isolated_environments(self):
        repo = SCRIPTS.parent.parent
        tests = repo / 'data/sgp.kits/test/ability_entrypoints'
        expected = {
            'assassinate': 'sgp.enderman',
            'bigger': 'sgp.tank',
            'cleave': 'sgp.combattant',
            'rays': 'sgp.roi',
            'smoke_grenade': 'sgp.eclaireur',
            'pecking': 'sgp.pigeon',
            'pecking_miss': 'sgp.pigeon',
            'no_matching_kit': None,
        }
        paths = sorted(tests.glob('*.mcfunction'))
        self.assertEqual([path.stem for path in paths], sorted(expected))

        for path in paths:
            text = path.read_text(encoding='utf-8')
            self.assertIn('execute at @s run function sgp.kits:abilities/route_ability', text, path)
            self.assertNotRegex(text, r'(?m)^function sgp\.kits:abilities/(?:assassinate|bigger|cleave|rays|smoke_grenade)/start(?: |$)')
            tag = expected[path.stem]
            if tag is not None:
                self.assertIn(f'tag @s add {tag}', text, path)
            env = re.search(r'^# @environment (\S+)$', text, re.MULTILINE)
            self.assertIsNotNone(env, path)
            self.assertEqual(env.group(1), f'sgp.ci:ability_entrypoints/{path.stem}')
            env_file = (repo / 'tests/fixtures/data/sgp.ci/test_environment/ability_entrypoints'
                        / f'{path.stem}.json')
            self.assertEqual(json.loads(env_file.read_text(encoding='utf-8')), {
                'type': 'minecraft:function',
                'setup': 'sgp.ci:ability_entrypoints/setup',
                'teardown': 'sgp.ci:ability_entrypoints/cleanup',
            })

        cleanup = (repo / 'tests/fixtures/data/sgp.ci/function/ability_entrypoints/cleanup.mcfunction').read_text(encoding='utf-8')
        self.assertIn('kill @e[tag=sgp.ci.ability_entrypoint]', cleanup)
        for player_id in range(920001, 920007):
            self.assertIn(f'data remove storage sgp.kits:stats kits_dict.{player_id}', cleanup)

    def test_hide_and_seek_fixture_clears_all_schedule_chains_at_both_boundaries(self):
        repo = SCRIPTS.parent.parent
        expected = (
            'schedule clear sgp.majeurs:hide_and_seek/_start',
            'schedule clear sgp.majeurs:hide_and_seek/_stop',
            'schedule clear sgp.majeurs:hide_and_seek/timer/hider',
            'schedule clear sgp.majeurs:hide_and_seek/timer/seeker',
            'schedule clear sgp.majeurs:hide_and_seek/timer/glow',
            'schedule clear sgp.majeurs:hide_and_seek/timer/glow_announce',
        )
        for name in ('setup', 'cleanup'):
            path = repo / 'tests/fixtures/data/sgp.ci/function/hider_teams' / f'{name}.mcfunction'
            text = path.read_text(encoding='utf-8')
            self.assertIn('function #bs.schedule:cancel_all {with:{id:"hide_and_seek"}}', text, path)
            for command in expected:
                self.assertIn(command, text, path)

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
