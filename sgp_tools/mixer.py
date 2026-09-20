"""Install pinned Mixer resources beneath SGP, merging load/tick tags explicitly."""
from pathlib import PurePosixPath
import hashlib
import json
import zipfile

SHA256 = '1765e994bed0da493376938559dbeb4570dc76d8aa6359191e3426f6c66cd7a9'
OVERRIDES = {'data/dah.actbar_mixer/function/z_private/display/render.mcfunction'}
MERGED_TAGS = {'data/minecraft/tags/function/load.json', 'data/minecraft/tags/function/tick.json'}


def install(server, archive):
    if hashlib.sha256(archive.read_bytes()).hexdigest() != SHA256:
        raise ValueError('Actionbar Mixer checksum mismatch')
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
    print('Installed Actionbar Mixer beneath SGP overrides; merged load/tick tags.')
