"""Offline checks for CI fixture isolation and dependency installation."""
from pathlib import Path
import hashlib
import json
import runpy
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


if __name__ == '__main__':
    unittest.main()
