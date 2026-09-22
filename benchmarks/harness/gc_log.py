"""JVM GC log parsing.

GC pauses stall the server thread inside whatever `/perf` section was running, so a
run's pause time is reported next to its tick metrics instead of hiding in them. The
server starts with `-Xlog:gc:file=gc.log:time,uptime`, which prints one line per pause:

    [2026-09-21T08:13:06.123+0200][12.345s] GC(5) Pause Young (Normal) (G1 Evacuation Pause) 300M->250M(6144M) 45.678ms

The heap left after the last pause matters as much as the pauses: PackTest dummy
players never drain the packets sent to them (their Connection has no channel, so
vanilla queues every packet as a pending action), which makes heavy scenarios retain
memory for the whole session and later runs GC-bound.
"""
from __future__ import annotations

from dataclasses import dataclass
from datetime import datetime
from pathlib import Path
import re

PAUSE_LINE = re.compile(
    r'^\[(?P<time>\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d{3}[+-]\d{4})\]'
    r'\[(?P<uptime>\d+(?:\.\d+)?)s\]'
    r'(?:\[[^\]]*\])*'
    r' GC\((?P<id>\d+)\) Pause (?P<kind>.+?) '
    r'(?P<before>\d+)(?P<before_unit>[KMGT])->(?P<after>\d+)(?P<after_unit>[KMGT])'
    r'\((?P<capacity>\d+)(?P<capacity_unit>[KMGT])\) (?P<ms>\d+(?:\.\d+)?)ms\s*$'
)
UNIT_MB = {'K': 1 / 1024, 'M': 1.0, 'G': 1024.0, 'T': 1024.0 * 1024.0}


@dataclass(frozen=True)
class GcPause:
    at: datetime
    uptime_s: float
    kind: str
    before_mb: float
    after_mb: float
    capacity_mb: float
    pause_ms: float


def parse_gc_log(path: Path) -> list[GcPause]:
    """Return every stop-the-world pause in a `-Xlog:gc` file (empty when the file is missing)."""
    if not path.is_file():
        return []
    pauses: list[GcPause] = []
    for line in path.read_text(encoding='utf-8', errors='replace').splitlines():
        match = PAUSE_LINE.match(line)
        if match is None:
            continue
        pauses.append(GcPause(
            at=datetime.strptime(match.group('time'), '%Y-%m-%dT%H:%M:%S.%f%z'),
            uptime_s=float(match.group('uptime')),
            kind=match.group('kind'),
            before_mb=int(match.group('before')) * UNIT_MB[match.group('before_unit')],
            after_mb=int(match.group('after')) * UNIT_MB[match.group('after_unit')],
            capacity_mb=int(match.group('capacity')) * UNIT_MB[match.group('capacity_unit')],
            pause_ms=float(match.group('ms')),
        ))
    return pauses


def summarize_gc(pauses: list[GcPause], start: datetime, end: datetime, tick_span: int | None) -> dict:
    """Pauses inside [start, end] plus the heap used after the last pause up to `end`.

    `heap_after_mb` is the occupancy right after that pause, which may be a young
    collection: it is an upper bound on what is reachable, not a liveness measurement.
    """
    window = [pause for pause in pauses if start <= pause.at <= end]
    total_ms = sum(pause.pause_ms for pause in window)
    seen = [pause for pause in pauses if pause.at <= end]
    last = seen[-1] if seen else None
    return {
        'pauses': len(window),
        'full_pauses': sum(1 for pause in window if pause.kind.startswith('Full')),
        'total_ms': total_ms,
        'max_ms': max((pause.pause_ms for pause in window), default=0.0),
        'ms_per_tick': (total_ms / tick_span) if tick_span else None,
        'heap_after_mb': last.after_mb if last is not None else None,
        'heap_capacity_mb': last.capacity_mb if last is not None else None,
    }
