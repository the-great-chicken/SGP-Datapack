"""Install pinned Mixer resources beneath SGP, merging load/tick tags explicitly."""
from pathlib import Path, PurePosixPath
import argparse
import hashlib
import json
import zipfile

SHA256 = '5adc9b3d60967ee3e0238b4ce65806fabf7168eecfdaea5632f349921595073d'
OVERRIDES = {'data/dah.actbar_mixer/function/z_private/display/self.mcfunction'}
MERGED_TAGS = {'data/minecraft/tags/function/load.json', 'data/minecraft/tags/function/tick.json'}


def install(server, archive):
    if hashlib.sha256(archive.read_bytes()).hexdigest() != SHA256:
        raise ValueError('Actionbar Mixer v1.3.3 checksum mismatch')
    pack = server / 'world/datapacks/SGP-Datapack'
    if not (pack / 'pack.mcmeta').is_file():
        raise ValueError('Prepare the CI datapack before installing Mixer')
    writes = {}
    with zipfile.ZipFile(archive) as source:
        for entry in source.infolist():
            name = entry.filename
            if entry.is_dir() or not name.startswith('data/'):
                continue
            if '..' in PurePosixPath(name).parts or '\\' in name:
                raise ValueError(f'Unsafe archive path: {name}')
            target = pack / name
            data = source.read(entry)
            if target.exists():
                if name in OVERRIDES:
                    continue
                if name not in MERGED_TAGS:
                    raise ValueError(f'Unexpected Mixer collision: {name}')
                dependency = json.loads(data)
                sgp = json.loads(target.read_text(encoding='utf-8'))
                if dependency.get('replace') or sgp.get('replace'):
                    raise ValueError(f'Cannot merge replacing tag: {name}')
                data = (json.dumps({'values': dependency['values'] + sgp['values']}, indent=2) + '\n').encode()
            writes[target] = data
    for target, data in writes.items():
        target.parent.mkdir(parents=True, exist_ok=True)
        target.write_bytes(data)
    print('Installed Actionbar Mixer v1.3.3 beneath SGP overrides; merged load/tick tags.')


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('server', type=Path)
    parser.add_argument('archive', type=Path)
    args = parser.parse_args()
    install(args.server, args.archive)
