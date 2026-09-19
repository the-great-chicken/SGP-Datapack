"""Semantic validation for Rays benchmark scenarios."""
from __future__ import annotations

from .base import ScenarioValidator
from ..errors import BenchmarkError, BenchmarkInvalidError
from ..runtime import actor_name
from ..server import ServerProcess

RAY_SCENARIOS = {'ability_rays', 'ability_rays_dense'}

def ray_player_count(plan: list[dict]) -> int:
    return sum(component['players'] for component in plan
               if component['scenario'] in RAY_SCENARIOS)


def validate_ray_workload(run: dict, plan: list[dict]) -> dict:
    """Require semantic Rays validation recorded by the live server checks.

    Profiler command strings are intentionally not used here: baseline and optimized
    implementations are allowed to perform the same workload differently.
    """
    players = ray_player_count(plan)
    if not players:
        return {}
    ticks = run.get('tick_span')
    if not isinstance(ticks, int) or ticks <= 0:
        raise BenchmarkInvalidError('Rays run is missing a positive profile tick count')
    validated = run.get('validated_workload')
    expected = {
        'ray_players': players,
        'ray_entities': players * 8,
        'ray_valid_owners': players,
    }
    if not isinstance(validated, dict) or any(validated.get(key) != value for key, value in expected.items()):
        raise BenchmarkInvalidError(
            'Rays run is missing a complete semantic ownership validation; '
            'rerun it with the current benchmark harness.'
        )
    return expected


def ray_actor_ranges(plan: list[dict]) -> list[tuple[int, int]]:
    ranges: list[tuple[int, int]] = []
    for component in plan:
        if component['scenario'] not in RAY_SCENARIOS:
            continue
        first = component.get('first')
        last = component.get('last')
        if not isinstance(first, int) or not isinstance(last, int) or last < first:
            raise BenchmarkError('Resolved Rays plan is missing a valid actor range')
        ranges.append((first, last))
    return ranges


def ray_actor_indices(plan: list[dict]) -> list[int]:
    indices: list[int] = []
    for first, last in ray_actor_ranges(plan):
        indices.extend(range(first, last + 1))
    return sorted(set(indices))


def _reset_ray_validation_state(server: ServerProcess):
    # Bookshelf predicates use shared input scores. Keep benchmark validation from
    # leaking the final actor's predicate inputs into subsequent server work.
    for player, objective in (
        ('$link.to', 'bs.in'),
        ('#ray_owner_id', 'sgp.bench'),
        ('#ray_linked', 'sgp.bench'),
        ('#ray_valid_owners', 'sgp.bench'),
        ('#ray_owned_by_actors', 'sgp.bench'),
    ):
        server.send(f'scoreboard players reset {player} {objective}')


def _run_ray_owner_validation(server: ServerProcess, plan: list[dict]):
    server.send('tag @e[tag=sgp.ray,type=item_display] remove sgp.bench.ray_owned')
    server.send('scoreboard players set #ray_valid_owners sgp.bench 0')
    for first, last in ray_actor_ranges(plan):
        server.send(
            'execute as @a[tag=sgp.bench.actor,'
            f'scores={{sgp.bench={first}..{last}}}] '
            'run function sgp.bench:scenarios/abilities/rays/verify_owner'
        )
    server.send(
        'execute store result score #ray_owned_by_actors sgp.bench '
        'if entity @e[tag=sgp.ray,tag=sgp.bench.ray_owned,type=item_display]'
    )
    server.send('tag @e[tag=sgp.ray,tag=sgp.bench.ray_owned,type=item_display] remove sgp.bench.ray_owned')


def _ray_owner_failure_details(server: ServerProcess, plan: list[dict]) -> list[str]:
    bad: list[str] = []
    for index in ray_actor_indices(plan):
        name = actor_name(index)
        for scoreholder in ('#ray_owner_id', '#ray_linked'):
            server.send(f'scoreboard players set {scoreholder} sgp.bench -1')
        server.send(f'execute as {name} run function sgp.bench:scenarios/abilities/rays/verify_owner')
        linked = server.score('#ray_linked')
        if linked == 8:
            continue
        bs_id = server.score('#ray_owner_id')
        bad.append(f'{name}(bs.id={bs_id!r}, linked={linked!r})')
    return bad


def require_ray_entities(server: ServerProcess, plan: list[dict], *, after_reset: bool = False) -> dict:
    players = ray_player_count(plan)
    if not players:
        return {}

    server.send('execute store result score #actual_rays sgp.bench if entity @e[tag=sgp.ray,type=item_display]')
    actual = server.score('#actual_rays')
    expected = 0 if after_reset else players * 8
    if after_reset:
        if actual != expected:
            raise BenchmarkInvalidError(f'Invalid rays entity count after reset: expected 0, got {actual!r}')
        return {}

    server.send(
        'execute store result score #ray_with_link sgp.bench '
        'if entity @e[tag=sgp.ray,predicate=bs.link:has_link,type=item_display]'
    )
    with_link = server.score('#ray_with_link')
    _run_ray_owner_validation(server, plan)
    valid_owners = server.score('#ray_valid_owners')
    owned_by_actors = server.score('#ray_owned_by_actors')

    valid = (
        actual == expected
        and with_link == expected
        and owned_by_actors == expected
        and valid_owners == players
    )
    if valid:
        _reset_ray_validation_state(server)
        return {
            'ray_players': players,
            'ray_entities': actual,
            'ray_valid_owners': valid_owners,
        }

    # Per-actor console queries are intentionally failure-only. The normal path
    # stays in-server so validation cannot distort warm-up by waiting on dozens of
    # command responses.
    bad = _ray_owner_failure_details(server, plan)
    _reset_ray_validation_state(server)
    details = '; '.join(bad[:12])
    if len(bad) > 12:
        details += f'; ... {len(bad) - 12} more'
    suffix = f' Broken owners: {details}.' if details else ''
    raise BenchmarkInvalidError(
        f'Invalid rays ownership: total rays {actual!r}/{expected}, '
        f'rays with any link {with_link!r}/{expected}, '
        f'rays owned by benchmark actors {owned_by_actors!r}/{expected}, '
        f'valid owners {valid_owners!r}/{players}.{suffix}'
    )

class RaysValidator(ScenarioValidator):
    name = 'rays'

    @staticmethod
    def _data(plan):
        return [component.as_dict() if hasattr(component, 'as_dict') else component for component in plan]

    def validate_live(self, server, plan, *, after_reset=False):
        return require_ray_entities(server, self._data(plan), after_reset=after_reset)

    def validate_profile(self, run, plan, live_validation):
        # The ownership check is server-semantic, not profiler-shape-dependent.
        data = self._data(plan)
        players = ray_player_count(data)
        expected = {
            'ray_players': players,
            'ray_entities': players * 8,
            'ray_valid_owners': players,
        }
        if any(live_validation.get(key) != value for key, value in expected.items()):
            raise BenchmarkInvalidError('Rays live validation did not produce the expected semantic result')
        return expected

    def validate_persisted(self, run, plan):
        return validate_ray_workload(run, self._data(plan))

    def matches_legacy_plan(self, plan):
        return bool(ray_player_count(self._data(plan)))

VALIDATOR = RaysValidator()
