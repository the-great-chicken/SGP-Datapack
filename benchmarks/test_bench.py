#!/usr/bin/env python3
"""Compatibility entrypoint for the split benchmark unit-test suite."""
from pathlib import Path
import sys
import unittest

BENCHMARKS = Path(__file__).resolve().parent
if str(BENCHMARKS) not in sys.path:
    sys.path.insert(0, str(BENCHMARKS))


if __name__ == '__main__':
    suite = unittest.defaultTestLoader.discover(
        start_dir=str(BENCHMARKS / 'bench_tests'),
        pattern='test_*.py',
        top_level_dir=str(BENCHMARKS),
    )
    result = unittest.TextTestRunner(verbosity=1).run(suite)
    raise SystemExit(0 if result.wasSuccessful() else 1)
