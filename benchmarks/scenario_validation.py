"""Shared validation for benchmark scenario definitions.

Kept independent of the runner and staging scripts so both paths reject the
same malformed scenario graph before a server is launched.
"""
from __future__ import annotations

from pathlib import Path
import json
import re


def load_scenarios(root: Path, *, error_type=ValueError) -> dict[str, dict]:
    scenarios: dict[str, dict] = {}
    for path in sorted(root.rglob('*.json')):
        data = json.loads(path.read_text(encoding='utf-8'))
        name = data.get('name')
        if not isinstance(name, str) or not name:
            raise error_type(f'{path}: scenario name must be a non-empty string')
        if path.stem != name:
            raise error_type(f'{path}: filename must match scenario name {name!r}')
        if name in scenarios:
            raise error_type(f'{path}: duplicate scenario name {name!r}')
        if not isinstance(data.get('description'), str):
            raise error_type(f'{path}: missing description')
        atomic = all(key in data for key in ('setup', 'tick', 'teardown', 'parameters'))
        composite = 'components' in data
        if atomic == composite:
            raise error_type(
                f'{path}: scenario must be exactly one of atomic '
                '(setup/tick/teardown/parameters) or composite (components)'
            )
        scenarios[name] = data
    if not scenarios:
        raise error_type('No benchmark scenarios found')
    return scenarios


def parameter_default(name: str, spec: dict, default_players: int, *, error_type=ValueError) -> int:
    if 'default' in spec:
        return spec['default']
    if name == 'players':
        return default_players
    raise error_type(f'Parameter {name!r} is missing a default')


def validate_parameter_specs(scenario: dict, default_players: int, *, error_type=ValueError) -> None:
    specs = scenario.get('parameters')
    if not isinstance(specs, dict) or 'players' not in specs:
        raise error_type(f'Scenario {scenario["name"]}: parameters must include players')
    for name, spec in specs.items():
        if not isinstance(spec, dict) or spec.get('type') != 'int':
            raise error_type(f'Scenario {scenario["name"]}: only int parameters are supported ({name})')
        if 'min' not in spec:
            raise error_type(f'Scenario {scenario["name"]}: parameter {name} is missing min')
        for key in ('min', 'max', 'default'):
            if key in spec and not isinstance(spec[key], int):
                raise error_type(f'Scenario {scenario["name"]}: parameter {name}.{key} must be an integer')
        default = parameter_default(name, spec, default_players, error_type=error_type)
        if default < spec['min'] or ('max' in spec and default > spec['max']):
            raise error_type(f'Scenario {scenario["name"]}: default for {name} is outside its range')


def validate_scenario_graph(scenarios: dict[str, dict], default_players: int, *, error_type=ValueError) -> None:
    counter_holders: dict[str, str] = {}
    for scenario in scenarios.values():
        if 'components' not in scenario:
            validate_parameter_specs(scenario, default_players, error_type=error_type)
            counters = scenario.get('counters', {})
            if not isinstance(counters, dict):
                raise error_type(f'Scenario {scenario["name"]}: counters must be an object')
            for counter_name, scoreholder in counters.items():
                if not isinstance(counter_name, str) or not re.fullmatch(r'[a-z0-9_.-]+', counter_name):
                    raise error_type(f'Scenario {scenario["name"]}: invalid counter name {counter_name!r}')
                if not isinstance(scoreholder, str) or not scoreholder.startswith('#') or len(scoreholder) > 40:
                    raise error_type(
                        f'Scenario {scenario["name"]}: counter {counter_name!r} must use a <=40-char # score holder'
                    )
                previous = counter_holders.get(scoreholder)
                if previous is not None and previous != scenario['name']:
                    raise error_type(
                        f'Counter score holder {scoreholder!r} is shared by scenarios {previous!r} and {scenario["name"]!r}'
                    )
                counter_holders[scoreholder] = scenario['name']
            continue

        components = scenario['components']
        if not isinstance(components, list) or not components:
            raise error_type(f'Scenario {scenario["name"]}: components must be a non-empty list')
        for index, component in enumerate(components, 1):
            if not isinstance(component, dict) or not isinstance(component.get('scenario'), str):
                raise error_type(f'Scenario {scenario["name"]}: component {index} must reference a scenario')
            target = component['scenario']
            if target not in scenarios:
                raise error_type(f'Scenario {scenario["name"]}: unknown component scenario {target!r}')
            if 'players' in component and (not isinstance(component['players'], int) or component['players'] < 0):
                raise error_type(f'Scenario {scenario["name"]}: component {index} players must be >= 0')
            overrides = component.get('parameters', {})
            if not isinstance(overrides, dict) or any(not isinstance(value, int) for value in overrides.values()):
                raise error_type(f'Scenario {scenario["name"]}: component {index} parameters must be integer values')

    def visit(name: str, stack: tuple[str, ...]) -> None:
        if name in stack:
            raise error_type(f'Benchmark scenario composition cycle: {" -> ".join((*stack, name))}')
        scenario = scenarios[name]
        if 'components' not in scenario:
            return
        for component in scenario['components']:
            visit(component['scenario'], (*stack, name))

    for name in scenarios:
        visit(name, ())
