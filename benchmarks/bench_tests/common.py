from __future__ import annotations

from contextlib import redirect_stdout
from io import StringIO
from pathlib import Path
import importlib.util
import json
import sys
import tempfile
import unittest
from unittest.mock import patch
import zipfile

import bench

ROOT = Path(__file__).resolve().parents[2]

def load_prepare_bench():
    path = ROOT / '.github/scripts/prepare_bench.py'
    spec = importlib.util.spec_from_file_location('test_prepare_bench', path)
    assert spec is not None and spec.loader is not None
    module = importlib.util.module_from_spec(spec)
    sys.modules[spec.name] = module
    try:
        spec.loader.exec_module(module)
    except Exception:
        sys.modules.pop(spec.name, None)
        raise
    return module


LIMIT_LINE = (
    '[Server thread/INFO]: Command execution stopped due to limit '
    f'(executed {bench.DEFAULT_COMMAND_LIMIT} commands)'
)

def make_server():
    return bench.ServerProcess(Path('unused'), 'unused-java', '2G')

def write_result_fixture(path: Path, command_percent: float, entry_percent: float):
    path.mkdir()
    (path / 'metadata.json').write_text(json.dumps({
        'scenario': 'idle',
        'parameters': {'players': 40},
        'status': 'complete',
        'runs': 3,
        'plan': [],
        'command_limit': bench.DEFAULT_COMMAND_LIMIT,
        'heap': '2G',
        'warmup_seconds': 5.0,
        'minecraft_version': '26.1.2',
        'git_commit': '0123456789abcdef0123456789abcdef01234567',
        'git_dirty': False,
    }), encoding='utf-8')
    for i in range(1, 4):
        (path / f'run-{i:02d}.json').write_text(json.dumps({
            'tick_span': 200,
            'time_span_ms': 10000.0,
            'effective_tps': 20.0,
            # Legacy key on purpose: comparison must upgrade it to tick_period_ms.
            'tick_time_ms': {'median': 4.0, 'p95': 8.0, 'max': 12.0},
            'command_functions_percent': command_percent,
            'harness_counters_after_profile_write': {
                'ticks': 201,
                'workload': {'ability_cleave.drop_inputs': 400, 'ability_cleave.waves': 10},
            },
            'command_function_entries': [{
                'name': 'function minecraft:execute_repeating_functions',
                'count': 200,
                'global_percent': entry_percent,
            }],
        }), encoding='utf-8')
