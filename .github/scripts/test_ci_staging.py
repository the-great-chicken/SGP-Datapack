#!/usr/bin/env python3
"""Compatibility entry point for the offline Python test suite."""
from pathlib import Path
import argparse
import sys
import unittest

ROOT = Path(__file__).resolve().parents[2]
if str(ROOT) not in sys.path:
    sys.path.insert(0, str(ROOT))


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('-q', '--quiet', action='store_true')
    parser.add_argument('-v', '--verbose', action='store_true')
    parser.add_argument('-f', '--failfast', action='store_true')
    args = parser.parse_args()
    if args.quiet and args.verbose:
        parser.error('--quiet and --verbose are mutually exclusive')

    suite = unittest.defaultTestLoader.discover(str(ROOT / 'tests/python'), pattern='test_*.py')
    verbosity = 0 if args.quiet else 2 if args.verbose else 1
    result = unittest.TextTestRunner(verbosity=verbosity, failfast=args.failfast).run(suite)
    raise SystemExit(0 if result.wasSuccessful() else 1)


if __name__ == '__main__':
    main()
