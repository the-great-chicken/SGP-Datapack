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

    def test_test_state_cannot_use_production_storage(self):
        root = Path(tempfile.mkdtemp(prefix='sgp-ci-storage-test-')) / 'data'
        file = root / 'sgp.ci/function/bad.mcfunction'
        file.parent.mkdir(parents=True)
        file.write_text('data modify storage sgp:data tests.bad set value {}\n')
        with self.assertRaisesRegex(ValueError, 'test-owned state must use sgp.ci storage'):
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


if __name__ == '__main__':
    unittest.main()
