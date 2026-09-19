#!/usr/bin/env python3
"""Validate removable namespaces and prepare a fresh plugin-free PackTest server.

Usage: python3 .github/scripts/prepare_core.py REPOSITORY NEW_SERVER_DIRECTORY
Only NEW_SERVER_DIRECTORY is written. Existing targets are rejected.
Uses only Python's standard library.
"""
from pathlib import Path
import argparse
import sys

ROOT = Path(__file__).resolve().parents[2]
if str(ROOT) not in sys.path:
    sys.path.insert(0, str(ROOT))

from sgp_tools.core_staging import *  # noqa: F401,F403


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('repository', type=Path)
    parser.add_argument('server', type=Path)
    args = parser.parse_args()
    prepare(args.repository, args.server)
