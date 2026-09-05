"""Validate removable namespaces and prepare a fresh plugin-free PackTest server.

Usage: python3 .github/scripts/prepare_core.py REPOSITORY NEW_SERVER_DIRECTORY
Only NEW_SERVER_DIRECTORY is written. Existing targets are rejected.
Uses only Python's standard library.
"""
from pathlib import Path
import argparse
import json
import re
import shutil

MODULES = ('sgp.integration.discord', 'sgp.integration.tab', 'sgp.integration.tgc')
PLUGIN_COMMAND = re.compile(
    r'(?:^\$?|\brun\s+)(?:[a-z0-9_.-]+:)?'
    r'(?:move|glow|useglow|statuswarp|luckperms|lp|playerlist|npc)\s*(?=$|[\s"}])'
)
HOOK_CALL = re.compile(r'\bfunction\s+#(sgp\.hooks:[a-z0-9_./-]+)')
FUNCTION_CALL = re.compile(r'\bfunction\s+(sgp\.integration\.[a-z]+:[a-z0-9_./-]+)(?![a-z0-9_./$(-])')
OBSOLETE = ('sgp.misc:tab/', 'sgp.lore:npcs/', 'sgp.lore:sgp_3/',
            'sgp.kits:abilities/remove_perms', 'sgp.to_remove_perm')


def function_file(data, identifier, kind='function'):
    namespace, name = identifier.split(':', 1)
    extension = '.mcfunction' if kind == 'function' else '.json'
    return data / namespace / kind / (name + extension)


def validate(data, core=False):
    errors = []
    files = [p for p in data.rglob('*') if p.is_file()]
    for namespace in MODULES:
        if core and (data / namespace).exists():
            errors.append(f'Core still contains {namespace}')
    for path in files:
        namespace = path.relative_to(data).parts[0]
        if path.suffix == '.json':
            try:
                document = json.loads(path.read_text(encoding='utf-8'))
            except (ValueError, UnicodeError) as exc:
                errors.append(f'{path}: invalid JSON: {exc}')
                continue
            if namespace == 'sgp.hooks' and 'tags/function' in path.as_posix():
                for entry in document.get('values', []):
                    if not isinstance(entry, dict) or entry.get('required') is not False:
                        errors.append(f'{path}: integration references must be optional')
                        continue
                    target = entry.get('id', '')
                    module = target.split(':')[0]
                    if module not in MODULES:
                        errors.append(f'{path}: unrecognized integration {target}')
                    elif (data / module).exists() and not function_file(data, target).is_file():
                        errors.append(f'{path}: installed integration lacks {target}')
            def walk(value):
                if isinstance(value, str) and value.lstrip('#').startswith('sgp.integration.'):
                    if namespace not in MODULES and namespace != 'sgp.hooks':
                        errors.append(f'{path}: core JSON references integration {value}')
                elif isinstance(value, dict):
                    for child in value.values():
                        walk(child)
                elif isinstance(value, list):
                    for child in value:
                        walk(child)
            walk(document)
        if path.suffix not in ('.json', '.mcfunction'):
            continue
        text = path.read_text(encoding='utf-8')
        for old in OBSOLETE:
            if old in text:
                errors.append(f'{path}: obsolete reference {old}')
        if path.suffix != '.mcfunction':
            continue
        for number, line in enumerate(text.splitlines(), 1):
            if line.lstrip().startswith('#'):
                continue
            if namespace not in MODULES and PLUGIN_COMMAND.search(line.strip()):
                errors.append(f'{path}:{number}: plugin command outside an integration')
            for target in HOOK_CALL.findall(line):
                if not function_file(data, target, 'tags/function').is_file():
                    errors.append(f'{path}:{number}: absent core hook {target}')
            for target in FUNCTION_CALL.findall(line):
                if namespace not in MODULES:
                    errors.append(f'{path}:{number}: core must call optional hooks: {target}')
                elif target.split(':')[0] != namespace:
                    errors.append(f'{path}:{number}: integration depends directly on another integration')
                elif not function_file(data, target).is_file():
                    errors.append(f'{path}:{number}: missing internal handler {target}')
    if errors:
        raise ValueError('\n'.join(errors))
    print(f'Validated {len(files)} resources ({"core" if core else "available integrations"}).')


def prepare(repository, server):
    repository = repository.resolve()
    server = server.resolve()
    if server.exists():
        raise ValueError(f'Refusing to overwrite an existing server directory: {server}')
    validate(repository / 'data')
    pack = server / 'world/datapacks/SGP-Datapack'
    pack.mkdir(parents=True)
    (pack / 'data').mkdir()
    for child in sorted((repository / 'data').iterdir()):
        if child.name in MODULES:
            continue
        target = pack / 'data' / child.name
        if child.is_dir():
            shutil.copytree(child, target)
        else:
            shutil.copy2(child, target)
    shutil.copy2(repository / 'pack.mcmeta', pack / 'pack.mcmeta')
    validate(pack / 'data', core=True)
    if not any((pack / 'data').glob('*/test/**/*.mcfunction')):
        raise ValueError('No core PackTest tests were found')
    # CI fixtures never become part of the production datapack.
    shutil.copytree(repository / '.github/packtest/data', pack / 'data', dirs_exist_ok=True)
    validate(pack / 'data', core=True)
    (server / 'server.properties').write_text(
        'level-name=world\nfunction-permission-level=4\n', encoding='utf-8')
    print(f'Prepared plugin-free server at {server}')


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('repository', type=Path)
    parser.add_argument('server', type=Path)
    args = parser.parse_args()
    prepare(args.repository, args.server)
