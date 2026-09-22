"""Collect function-hit coverage for the staged datapack used by PackTest.

The CI-only instrument command prepends a one-time log marker to every production
function in the staged core datapack. The report command parses those markers
from the dedicated-server console log and reports function coverage per
namespace. Production files are never modified.

Usage:
  python3 .github/scripts/datapack_coverage.py instrument REPOSITORY SERVER
  python3 .github/scripts/datapack_coverage.py report REPOSITORY SERVER [--summary FILE]
"""
from pathlib import Path
import argparse
import sys

ROOT = Path(__file__).resolve().parents[2]
if str(ROOT) not in sys.path:
    sys.path.insert(0, str(ROOT))

from sgp_tools.coverage import *  # noqa: F401,F403


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    subparsers = parser.add_subparsers(dest='command', required=True)

    instrument_parser = subparsers.add_parser('instrument')
    instrument_parser.add_argument('repository', type=Path)
    instrument_parser.add_argument('server', type=Path)

    report_parser = subparsers.add_parser('report')
    report_parser.add_argument('repository', type=Path)
    report_parser.add_argument('server', type=Path)
    report_parser.add_argument('--summary', type=Path)

    args = parser.parse_args()
    if args.command == 'instrument':
        instrument(args.repository, args.server)
    else:
        report(args.repository, args.server, args.summary)


if __name__ == '__main__':
    main()
