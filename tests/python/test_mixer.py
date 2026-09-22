import hashlib
import json
import zipfile
from unittest import mock

from common import RepositoryTestCase
from sgp_tools import mixer


class MixerTests(RepositoryTestCase):
    def test_install_keeps_sgp_overrides_and_installs_mixer_self(self):
        root = self.temporary_path()
        pack = root / 'world/datapacks/SGP-Datapack'
        override = 'data/dah.actbar_mixer/function/z_private/display/render.mcfunction'
        tick_override = 'data/dah.actbar_mixer/function/z_private/tick.mcfunction'
        mixer_self = 'data/dah.actbar_mixer/function/z_private/display/self.mcfunction'
        hook = 'data/minecraft/tags/function/load.json'
        for path, text in [
            ('pack.mcmeta', '{}'),
            (override, 'SGP render override'),
            (tick_override, 'SGP tick override'),
            (hook, json.dumps({'values': ['sgp:load']})),
        ]:
            file = pack / path
            file.parent.mkdir(parents=True, exist_ok=True)
            file.write_text(text)
        archive = root / 'test-mixer.zip'
        with zipfile.ZipFile(archive, 'w') as output:
            output.writestr(override, 'Mixer render base')
            output.writestr(tick_override, 'Mixer tick base')
            output.writestr(mixer_self, 'Mixer self')
            output.writestr(hook, json.dumps({'values': ['mixer:load']}))
            output.writestr('data/mixer/function/register.mcfunction', 'say registered')

        with self.assertRaisesRegex(ValueError, 'checksum mismatch'):
            mixer.install(root, archive)
        checksum = hashlib.sha256(archive.read_bytes()).hexdigest()
        with mock.patch.object(mixer, 'SHA256', checksum):
            mixer.install(root, archive)

        self.assertEqual((pack / override).read_text(), 'SGP render override')
        self.assertEqual((pack / tick_override).read_text(), 'SGP tick override')
        self.assertEqual((pack / mixer_self).read_text(), 'Mixer self')
        self.assertEqual(json.loads((pack / hook).read_text())['values'], ['mixer:load', 'sgp:load'])
        self.assertEqual((pack / 'data/mixer/function/register.mcfunction').read_text(), 'say registered')
