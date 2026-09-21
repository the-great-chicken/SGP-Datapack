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
    # Wall-clock interval between consecutive ticks (server/metrics/ticking.csv).
    # This is NOT work time: it sits at ~50 ms whenever the server keeps up, so it
    # only reflects load once the server is saturated.
    tick_periods_ms: list[float]
    # Root split of the captured wall time. Vanilla prints `tick` and
    # `nextTickWait` at depth 0 of the profiler dump.
    tick_percent: float | None = None
    next_tick_wait_percent: float | None = None
    # Commands the datapack ran per tick (`execute` sections under commandFunctions);
    # `prepared` also counts lines whose conditions failed before execution.
    commands_executed_per_tick: float | None = None
    commands_prepared_per_tick: float | None = None
    # Entity ticking (`entities` under the level tick), global % and per entity type.
    entities_percent: float | None = None
    entity_type_percent: dict[str, float] | None = None
    # JVM stop-the-world pauses during the capture (gc_log.summarize_gc); the
    # runner fills it in, archives parsed on their own have none.
    gc: dict | None = None

    @property
    def effective_tps(self) -> float | None:
        if not self.time_span_ms or self.tick_span is None:
            return None
        return self.tick_span * 1000.0 / self.time_span_ms

    def _ms_per_tick(self, percent: float | None) -> float | None:
        if percent is None or not self.time_span_ms or not self.tick_span:
            return None
        return self.time_span_ms * percent / 100.0 / self.tick_span

    @property
    def mean_mspt_ms(self) -> float | None:
        """Mean server work per tick: the profiler's `tick` share of the captured wall time."""
        return self._ms_per_tick(self.tick_percent)

    @property
    def command_functions_ms_per_tick(self) -> float | None:
        """Absolute datapack cost per tick; comparable across runs even when TPS differs."""
        return self._ms_per_tick(self.command_functions_percent)

    @property
    def tick_period_median_ms(self) -> float | None:
        return float(median(self.tick_periods_ms)) if self.tick_periods_ms else None

    @property
    def tick_period_mean_ms(self) -> float | None:
        return float(fmean(self.tick_periods_ms)) if self.tick_periods_ms else None

    @property
    def tick_period_p95_ms(self) -> float | None:
        return percentile(self.tick_periods_ms, 0.95)

    @property
    def tick_period_p99_ms(self) -> float | None:
        return percentile(self.tick_periods_ms, 0.99)

    @property
    def tick_period_max_ms(self) -> float | None:
        return max(self.tick_periods_ms) if self.tick_periods_ms else None

    @property
    def entities_ms_per_tick(self) -> float | None:
        return self._ms_per_tick(self.entities_percent)

    def entity_type_ms_per_tick(self) -> dict[str, float]:
        result = {}
        for name, percent in (self.entity_type_percent or {}).items():
            value = self._ms_per_tick(percent)
            if value is not None:
                result[name] = value
        return result

    @property
    def gc_ms_per_tick(self) -> float | None:
        return (self.gc or {}).get('ms_per_tick')

    @property
    def gc_heap_after_mb(self) -> float | None:
        return (self.gc or {}).get('heap_after_mb')

    @property
    def gc_heap_capacity_mb(self) -> float | None:
        return (self.gc or {}).get('heap_capacity_mb')


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
