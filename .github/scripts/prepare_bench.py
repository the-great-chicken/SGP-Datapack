#!/usr/bin/env python3
"""Prepare a fresh plugin-free PackTest benchmark server.

Usage: python3 .github/scripts/prepare_bench.py REPOSITORY NEW_SERVER_DIRECTORY
Only NEW_SERVER_DIRECTORY is written. Existing targets are rejected.
Uses only Python's standard library.
"""
from pathlib import Path
import argparse
import sys

ROOT = Path(__file__).resolve().parents[2]
if str(ROOT) not in sys.path:
    sys.path.insert(0, str(ROOT))

from benchmarks.harness import scenario_schema as _SCENARIO_VALIDATION
from benchmarks.harness.staging import (
    append_tag_value,
    function_file,
    load_staging_scenarios,
    prepare_benchmark_datapack,
    validate_scenario_entrypoints,
)

# Compatibility names used by staging tests and any external callers of this script.
load_scenarios = load_staging_scenarios
validate_scenarios = validate_scenario_entrypoints
prepare = prepare_benchmark_datapack


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('repository', type=Path)
    parser.add_argument('server', type=Path)
    args = parser.parse_args()
    prepare(args.repository, args.server)
