"""Compatibility facade for benchmark scenario schema validation."""
from __future__ import annotations

from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parent.parent
if str(ROOT) not in sys.path:
    sys.path.insert(0, str(ROOT))

from benchmarks.harness.scenario_schema import *  # noqa: F401,F403
