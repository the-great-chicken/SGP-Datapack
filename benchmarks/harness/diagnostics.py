"""Persistence for benchmark success and failure diagnostics."""
from __future__ import annotations

from datetime import datetime
from pathlib import Path
import json
import shutil

from .models import PlanComponent
from .runtime import plan_total_players
from .server import ServerProcess

def copy_if_file(source: Path, destination: Path):
    if source.is_file():
        destination.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(source, destination)


def write_failure_bundle(result_dir: Path, metadata: dict, phase: str, exc: Exception,
                         server_dir: Path, server: ServerProcess | None, plan: list[PlanComponent]):
    tail = server.lines[-120:] if server is not None else []
    failure = {
        'failed_at': datetime.now().astimezone().isoformat(),
        'phase': phase,
        'error_type': type(exc).__name__,
        'error': str(exc),
        'server_dir': str(server_dir),
        'recent_console_lines': tail,
    }
    (result_dir / 'failure.json').write_text(json.dumps(failure, indent=2) + '\n', encoding='utf-8')

    metadata = dict(metadata)
    metadata['status'] = 'failed'
    metadata['failure'] = {'phase': phase, 'error_type': type(exc).__name__, 'error': str(exc)}
    (result_dir / 'metadata.json').write_text(json.dumps(metadata, indent=2) + '\n', encoding='utf-8')

    diagnostics = result_dir / 'diagnostics'
    copy_if_file(server_dir / 'benchmark-console.log', diagnostics / 'benchmark-console.log')
    copy_if_file(server_dir / 'logs/latest.log', diagnostics / 'latest.log')
    copy_if_file(server_dir / 'server.properties', diagnostics / 'server.properties')
    datapack_bench = server_dir / 'world/datapacks/SGP-Datapack/data/sgp.bench/function'
    copy_if_file(datapack_bench / 'fixture/setup.mcfunction', diagnostics / 'fixture-setup.mcfunction')
    copy_if_file(datapack_bench / 'load.mcfunction', diagnostics / 'benchmark-load.mcfunction')
    active = datapack_bench / 'generated/active'
    if active.is_dir():
        target = diagnostics / 'generated-active'
        target.mkdir(parents=True, exist_ok=True)
        for source in active.glob('*.mcfunction'):
            shutil.copy2(source, target / source.name)
    actors = datapack_bench / 'actors'
    for name in ('spawn.mcfunction', 'cleanup.mcfunction'):
        copy_if_file(actors / name, diagnostics / 'generated-actors' / name)

    lines = [
        '# Benchmark failed',
        '',
        f'- Phase: `{phase}`',
        f'- Error: `{type(exc).__name__}: {str(exc).replace("`", "\\`")}`',
        f'- Scenario: `{metadata.get("scenario")}`',
        f'- Total players: {plan_total_players(plan)}',
        '',
        'The raw diagnostics are in `failure.json` and `diagnostics/`. In particular, '
        '`diagnostics/benchmark-console.log` preserves the dedicated-server console when available.',
        '',
    ]
    if tail:
        lines += ['## Last server console lines', '', '```text', *tail[-40:], '```', '']
    (result_dir / 'failure.md').write_text('\n'.join(lines), encoding='utf-8')


def mark_success(result_dir: Path, metadata: dict):
    metadata = dict(metadata)
    metadata['status'] = 'complete'
    metadata['completed_at'] = datetime.now().astimezone().isoformat()
    (result_dir / 'metadata.json').write_text(json.dumps(metadata, indent=2) + '\n', encoding='utf-8')
