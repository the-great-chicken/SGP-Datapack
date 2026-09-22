#!/usr/bin/env python3
"""Install pinned Mixer resources beneath SGP, merging load/tick tags explicitly."""
from pathlib import Path
import argparse
import sys

ROOT = Path(__file__).resolve().parents[2]
if str(ROOT) not in sys.path:
    sys.path.insert(0, str(ROOT))

from sgp_tools.mixer import *  # noqa: F401,F403


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('server', type=Path)
    parser.add_argument('archive', type=Path)
    args = parser.parse_args()
    install(args.server, args.archive)
