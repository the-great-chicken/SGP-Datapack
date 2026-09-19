"""Semantic validation for the Diorama giant benchmark scenario."""
from __future__ import annotations

from .base import ScenarioValidator
from ..errors import BenchmarkInvalidError
from ..server import ServerProcess

def validate_diorama_workload(run: dict, plan: list[dict]) -> dict:
    players = sum(component['players'] for component in plan if component['scenario'] == 'diorama_giant')
    if not players:
        return {}
    ticks = run.get('tick_span')
    if not isinstance(ticks, int) or ticks <= 0:
        raise BenchmarkInvalidError('Cannot validate Diorama without a positive profile tick count')
    updates = sum(
        entry['count'] for entry in run.get('command_function_entries', [])
        if 'function sgp.diorama:tick/update_mannequin/apply_mannequin_pos' in entry.get('name', '')
    )
    expected = players * ticks
    if updates != expected:
        raise BenchmarkInvalidError(
            f'Incomplete Diorama workload over {ticks} ticks: mannequin updates {updates}/{expected}'
        )
    return {'diorama_mannequin_updates': updates}


def require_diorama_entities(server: ServerProcess, plan: list[dict], *, after_reset: bool = False):
    components = [component for component in plan if component['scenario'] == 'diorama_giant']
    if not components:
        return
    expected = 0 if after_reset else sum(component['players'] for component in components)
    server.send('execute positioned 0 121 0 store result score #actual_mannequins sgp.bench '
                'if entity @e[tag=sgp.giant_mannequin_99001,distance=..256,type=mannequin]')
    actual = server.score('#actual_mannequins')
    if actual != expected:
        raise BenchmarkInvalidError(f'Invalid Diorama mannequin count: expected {expected}, got {actual!r}')
    if after_reset:
        return
    server.send('scoreboard players set #diorama_valid_owners sgp.bench 0')
    for component in components:
        server.send(f'execute as @a[tag=sgp.bench.actor,scores={{sgp.bench={component["first"]}..{component["last"]}}}] '
                    'run function sgp.bench:scenarios/systems/diorama_giant/verify_owner')
    owners = server.score('#diorama_valid_owners')
    if owners != expected:
        raise BenchmarkInvalidError(f'Invalid Diorama ownership: {owners!r}/{expected} players own exactly one mannequin')

class DioramaValidator(ScenarioValidator):
    name = 'diorama'

    @staticmethod
    def _data(plan):
        return [component.as_dict() if hasattr(component, 'as_dict') else component for component in plan]

    def validate_live(self, server, plan, *, after_reset=False):
        require_diorama_entities(server, self._data(plan), after_reset=after_reset)
        return {}

    def validate_profile(self, run, plan, live_validation):
        return validate_diorama_workload(run, self._data(plan))

    def validate_persisted(self, run, plan):
        return validate_diorama_workload(run, self._data(plan))

    def matches_legacy_plan(self, plan):
        return any(component['scenario'] == 'diorama_giant' for component in self._data(plan))

VALIDATOR = DioramaValidator()
