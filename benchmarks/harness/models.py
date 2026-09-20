"""Typed values shared across benchmark subsystems."""
from __future__ import annotations

from dataclasses import dataclass
from pathlib import Path
from statistics import fmean, median
import math

def percentile(values: list[float], quantile: float) -> float | None:
    """Nearest-rank percentile, adequate for the ~200 tick samples in /perf."""
    if not values:
        return None
    if not 0.0 <= quantile <= 1.0:
        raise ValueError(f'quantile must be between 0 and 1, got {quantile}')
    ordered = sorted(values)
    rank = max(1, math.ceil(len(ordered) * quantile))
    return float(ordered[min(rank, len(ordered)) - 1])


@dataclass(frozen=True)
class ProfileEntry:
    depth: int
    name: str
    count: int
    per_tick: int
    parent_percent: float
    global_percent: float


@dataclass
class ParsedProfile:
    archive: Path
    time_span_ms: float | None
    tick_span: int | None
    version: str | None
    command_functions_percent: float | None
    entries: list[ProfileEntry]
    scheduled_entries: list[ProfileEntry]
    tick_times_ms: list[float]

    @property
    def effective_tps(self) -> float | None:
        if not self.time_span_ms or self.tick_span is None:
            return None
        return self.tick_span * 1000.0 / self.time_span_ms

    @property
    def tick_median_ms(self) -> float | None:
        return float(median(self.tick_times_ms)) if self.tick_times_ms else None

    @property
    def tick_mean_ms(self) -> float | None:
        return float(fmean(self.tick_times_ms)) if self.tick_times_ms else None

    @property
    def tick_p95_ms(self) -> float | None:
        return percentile(self.tick_times_ms, 0.95)

    @property
    def tick_p99_ms(self) -> float | None:
        return percentile(self.tick_times_ms, 0.99)

    @property
    def tick_max_ms(self) -> float | None:
        return max(self.tick_times_ms) if self.tick_times_ms else None


@dataclass
class PlanComponent:
    scenario: str
    players: int
    first: int | None
    last: int | None
    parameters: dict[str, int]
    setup: str
    tick: str
    teardown: str
    measurement_prepare: str | None
    measurement_reset: str | None
    counters: dict[str, str]
    validators: tuple[str, ...] = ()

    def as_dict(self) -> dict:
        data = {
            'scenario': self.scenario,
            'players': self.players,
            'first': self.first,
            'last': self.last,
            'parameters': self.parameters,
            'setup': self.setup,
            'tick': self.tick,
            'teardown': self.teardown,
            'counters': self.counters,
        }
        if self.measurement_prepare is not None:
            data['measurement_prepare'] = self.measurement_prepare
        if self.measurement_reset is not None:
            data['measurement_reset'] = self.measurement_reset
        return data
