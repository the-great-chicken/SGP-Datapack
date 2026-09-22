"""Paths and static benchmark configuration."""
from __future__ import annotations

from pathlib import Path
import json

ROOT = Path(__file__).resolve().parents[2]
BENCHMARKS = ROOT / 'benchmarks'
DEFAULT_SERVER = ROOT / '.packtest-bench-server'
DEFAULT_CACHE = ROOT / '.bench-cache'
DEFAULT_RESULTS = BENCHMARKS / 'results'
DEFAULT_COMMAND_LIMIT = 65536
MAX_COMMAND_LIMIT = 2147483647
COMMAND_LIMIT_TOLERANCE = 0.1
SERVER_MARKER = '.sgp-benchmark-server'
INVALID_MARKER = '.sgp-benchmark-invalid'
CONFIG = json.loads((BENCHMARKS / 'config.json').read_text(encoding='utf-8'))
