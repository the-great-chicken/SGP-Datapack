"""Semantic validation for the detonating Bats benchmark scenario."""
from __future__ import annotations

import time

from .base import ScenarioValidator
from ..errors import BenchmarkError, BenchmarkInvalidError
from ..server import ServerProcess

SCENARIO = 'ability_bats_detonating'
BATS_PER_ACTIVATION = 10
# The benchmark driver drops the ability input at the end of the datapack tick,
# after the production ability router has already run. The bats therefore spawn
# on the following tick. Their scheduled 1-second scan detonates on driver tick
# + 20 in the profiler's tick numbering.
SPAWN_DELAY_TICKS = 1
DETONATION_DELAY_TICKS = 20


def _components(plan: list[dict]) -> list[dict]:
    return [component for component in plan if component['scenario'] == SCENARIO]


def bats_player_count(plan: list[dict]) -> int:
    return sum(component['players'] for component in _components(plan))


def bats_actor_ranges(plan: list[dict]) -> list[tuple[int, int]]:
    ranges: list[tuple[int, int]] = []
    for component in _components(plan):
        first = component.get('first')
        last = component.get('last')
        if not isinstance(first, int) or not isinstance(last, int) or last < first:
            raise BenchmarkError('Resolved detonating Bats plan is missing a valid actor range')
        ranges.append((first, last))
    return ranges


def _period(component: dict) -> int:
    period = component.get('parameters', {}).get('period')
    if not isinstance(period, int) or period <= 0:
        raise BenchmarkError('Resolved detonating Bats plan is missing a positive period')
    return period


def _waves_visible_by(ticks: int, period: int, delay_ticks: int) -> int:
    if ticks <= delay_ticks:
        return 0
    return 1 + (ticks - delay_ticks - 1) // period


def _expected_profile_counts(ticks: int, plan: list[dict]) -> tuple[int, int]:
    spawned = 0
    detonated = 0
    for component in _components(plan):
        players = component['players']
        if players <= 0:
            continue
        period = _period(component)
        activations = _waves_visible_by(ticks, period, SPAWN_DELAY_TICKS)
        completed = _waves_visible_by(ticks, period, DETONATION_DELAY_TICKS)
        spawned += players * BATS_PER_ACTIVATION * activations
        detonated += players * BATS_PER_ACTIVATION * completed
    return spawned, detonated


def _profile_count(run: dict, key: str, *needles: str) -> int:
    entries = run.get(key)
    if not isinstance(entries, list):
        return 0
    return sum(
        entry.get('count', 0)
        for entry in entries
        if isinstance(entry, dict)
        and isinstance(entry.get('count'), int)
        and isinstance(entry.get('name'), str)
        and all(needle in entry['name'] for needle in needles)
    )


def validate_bats_profile(run: dict, plan: list[dict]) -> dict:
    players = bats_player_count(plan)
    if not players:
        return {}
    ticks = run.get('tick_span')
    if not isinstance(ticks, int) or ticks <= 0:
        raise BenchmarkInvalidError('Cannot validate detonating Bats without a positive profile tick count')

    expected_spawned, expected_detonated = _expected_profile_counts(ticks, plan)
    spawned = _profile_count(
        run,
        'command_function_entries',
        'summon bat run function sgp.misc:summon_multiple_exec',
        'sgp.bat_grenade',
    )
    detonated = _profile_count(
        run,
        'scheduled_function_entries',
        'summon tnt ~ ~ ~',
        'sgp.bat_grenade',
    )
    if spawned != expected_spawned:
        raise BenchmarkInvalidError(
            f'Incomplete detonating Bats spawn workload over {ticks} ticks: '
            f'grenade bats {spawned}/{expected_spawned}'
        )
    if detonated != expected_detonated:
        raise BenchmarkInvalidError(
            f'Incomplete detonating Bats detonation workload over {ticks} ticks: '
            f'grenade TNT {detonated}/{expected_detonated}'
        )
    return {
        'bats_players': players,
        'bats_spawned': spawned,
        'bats_detonated': detonated,
    }


def require_bat_targets(server: ServerProcess, plan: list[dict], *, after_reset: bool = False) -> dict:
    players = bats_player_count(plan)
    if not players:
        return {}

    server.send(
        'execute store result score #bats_targets sgp.bench '
        'if entity @e[tag=sgp.bench.bat_target,type=mannequin]'
    )
    actual = server.score('#bats_targets')
    expected = 0 if after_reset else players
    if actual != expected:
        raise BenchmarkInvalidError(
            f'Invalid detonating Bats target count: expected {expected}, got {actual!r}'
        )

    if after_reset:
        server.send(
            'execute store result score #bats_grenades sgp.bench '
            'if entity @e[tag=sgp.bat_grenade]'
        )
        grenades = server.score('#bats_grenades')
        if grenades != 0:
            raise BenchmarkInvalidError(
                f'Detonating Bats teardown left {grenades!r} grenade entities behind'
            )
        return {}

    server.send('scoreboard players set #bats_targets_in_place sgp.bench 0')
    for first, last in bats_actor_ranges(plan):
        server.send(
            'execute as @a[tag=sgp.bench.actor,'
            f'scores={{sgp.bench={first}..{last}}}] at @s '
            'if entity @e[tag=sgp.bench.bat_target,type=mannequin,distance=..0.25] '
            'run scoreboard players add #bats_targets_in_place sgp.bench 1'
        )
    in_place = server.score('#bats_targets_in_place')
    if in_place != players:
        raise BenchmarkInvalidError(
            'Detonating Bats targets moved away from their actors: '
            f'{in_place!r}/{players} remain in place'
        )
    return {
        'bats_target_mannequins': actual,
        'bats_targets_in_place': in_place,
    }


def wait_for_bat_cleanup(server: ServerProcess, plan: list[dict], *, timeout: float) -> None:
    """Wait until bats killed by measurement preparation have fully left the world.

    `/kill` starts the normal living-entity death lifecycle; it does not discard
    a bat immediately. Profiling before those entities disappear would include
    roughly one second of warm-up corpse ticks. measurement_prepare moves the
    scenario clock far from its fire threshold while this waits, so no replacement
    wave can spawn and composed workloads can keep warming normally.
    """
    if not bats_player_count(plan):
        return

    deadline = time.monotonic() + timeout
    while True:
        server.send(
            'execute store result score #bats_measurement_grenades sgp.bench '
            'if entity @e[tag=sgp.bat_grenade]'
        )
        remaining = deadline - time.monotonic()
        if remaining <= 0:
            raise BenchmarkInvalidError(
                'Timed out waiting for warm-up grenade bats to leave the world before profiling'
            )
        grenades = server.score(
            '#bats_measurement_grenades', timeout=min(5.0, remaining)
        )
        if grenades == 0:
            server.send('scoreboard players reset #bats_measurement_grenades sgp.bench')
            return
        if grenades is None:
            raise BenchmarkError('Could not read warm-up grenade bat count before profiling')
        server.sleep_alive(min(0.05, max(0.0, deadline - time.monotonic())))


def validate_bats_workload(run: dict, plan: list[dict]) -> dict:
    profile = validate_bats_profile(run, plan)
    if not profile:
        return {}
    players = profile['bats_players']
    expected = {
        **profile,
        'bats_target_mannequins': players,
        'bats_targets_in_place': players,
    }
    validated = run.get('validated_workload')
    if not isinstance(validated, dict) or any(validated.get(key) != value for key, value in expected.items()):
        raise BenchmarkInvalidError(
            'Detonating Bats run is missing complete semantic target validation; '
            'rerun it with the current benchmark harness.'
        )
    return expected


class BatsDetonatingValidator(ScenarioValidator):
    name = 'bats_detonating'

    @staticmethod
    def _data(plan):
        return [component.as_dict() if hasattr(component, 'as_dict') else component for component in plan]

    def validate_live(self, server, plan, *, after_reset=False):
        return require_bat_targets(server, self._data(plan), after_reset=after_reset)

    def wait_measurement_ready(self, server, plan, *, timeout):
        wait_for_bat_cleanup(server, self._data(plan), timeout=timeout)

    def validate_profile(self, run, plan, live_validation):
        data = self._data(plan)
        profile = validate_bats_profile(run, data)
        if not profile:
            return {}
        players = profile['bats_players']
        expected_live = {
            'bats_target_mannequins': players,
            'bats_targets_in_place': players,
        }
        if any(live_validation.get(key) != value for key, value in expected_live.items()):
            raise BenchmarkInvalidError('Detonating Bats live target validation did not produce the expected result')
        return {**profile, **expected_live}

    def validate_persisted(self, run, plan):
        return validate_bats_workload(run, self._data(plan))

    def matches_legacy_plan(self, plan):
        return bool(bats_player_count(self._data(plan)))


VALIDATOR = BatsDetonatingValidator()
