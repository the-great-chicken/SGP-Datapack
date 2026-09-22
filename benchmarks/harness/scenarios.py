"""Scenario loading, parameter resolution, and composition."""
from __future__ import annotations

from . import scenario_schema
from .errors import BenchmarkError
from .models import PlanComponent
from .settings import BENCHMARKS, CONFIG

def load_scenarios() -> dict[str, dict]:
    scenarios = scenario_schema.load_scenarios(
        BENCHMARKS / 'scenarios', error_type=BenchmarkError
    )
    validate_scenario_graph(scenarios)
    return scenarios


def parameter_default(name: str, spec: dict) -> int:
    return scenario_schema.parameter_default(
        name, spec, int(CONFIG['default_players']), error_type=BenchmarkError
    )


def validate_parameter_specs(scenario: dict):
    scenario_schema.validate_parameter_specs(
        scenario, int(CONFIG['default_players']), error_type=BenchmarkError
    )


def validate_scenario_graph(scenarios: dict[str, dict]):
    scenario_schema.validate_scenario_graph(
        scenarios, int(CONFIG['default_players']), error_type=BenchmarkError
    )


def parse_raw_params(raw_params: list[str]) -> dict[str, int]:
    parsed: dict[str, int] = {}
    for item in raw_params:
        if '=' not in item:
            raise BenchmarkError(f'Invalid --param {item!r}; expected NAME=INTEGER')
        name, value = item.split('=', 1)
        try:
            parsed[name] = int(value)
        except ValueError as exc:
            raise BenchmarkError(f'Parameter {name!r} must be an integer') from exc
    return parsed


def parameter_values(scenario: dict, players: int | None = None,
                     overrides: dict[str, int] | None = None) -> dict[str, int]:
    validate_parameter_specs(scenario)
    specs = scenario['parameters']
    values = {name: parameter_default(name, spec) for name, spec in specs.items()}
    if players is not None:
        values['players'] = players
    for name, value in (overrides or {}).items():
        if name == 'players':
            raise BenchmarkError('Set component player counts with "players", not parameters.players')
        if name not in specs:
            raise BenchmarkError(f'Unknown parameter {name!r} for scenario {scenario["name"]}')
        values[name] = value
    for name, spec in specs.items():
        value = values[name]
        minimum = int(spec['min'])
        maximum = int(spec['max']) if 'max' in spec else None
        if value < minimum or (maximum is not None and value > maximum):
            upper = str(maximum) if maximum is not None else 'unbounded'
            raise BenchmarkError(
                f'{name}={value} is outside {minimum}..{upper} for scenario {scenario["name"]}'
            )
    return values


def validate_parameters(scenario: dict, players: int | None, raw_params: list[str]) -> dict[str, int]:
    if 'components' in scenario:
        if players is not None or raw_params:
            raise BenchmarkError(
                f'Scenario {scenario["name"]} is a composition; configure its component counts/parameters in JSON'
            )
        return {}
    return parameter_values(scenario, players, parse_raw_params(raw_params))


def resolve_plan(scenarios: dict[str, dict], name: str, players: int | None = None,
                 raw_params: list[str] | None = None) -> tuple[dict, dict[str, int], list[PlanComponent]]:
    if name not in scenarios:
        raise BenchmarkError(f'Unknown scenario {name!r}; use `list` to see available scenarios')
    selected = scenarios[name]
    top_params = validate_parameters(selected, players, raw_params or [])
    plan: list[PlanComponent] = []
    cursor = 1

    def add_atomic(scenario: dict, count: int | None, overrides: dict[str, int] | None):
        nonlocal cursor
        values = parameter_values(scenario, count, overrides)
        actor_count = values['players']
        first = cursor if actor_count else None
        last = cursor + actor_count - 1 if actor_count else None
        params = {key: value for key, value in values.items() if key != 'players'}
        plan.append(PlanComponent(
            scenario=scenario['name'], players=actor_count, first=first, last=last,
            parameters=params, setup=scenario['setup'], tick=scenario['tick'], teardown=scenario['teardown'],
            measurement_prepare=scenario.get('measurement_prepare'),
            measurement_reset=scenario.get('measurement_reset'),
            counters=dict(scenario.get('counters', {})),
            validators=tuple(scenario.get('validators', ())),
        ))
        cursor += actor_count

    def expand(scenario_name: str, component: dict | None = None, stack: tuple[str, ...] = ()):
        scenario = scenarios[scenario_name]
        if scenario_name in stack:
            raise BenchmarkError(f'Benchmark scenario composition cycle: {" -> ".join((*stack, scenario_name))}')
        if 'components' not in scenario:
            add_atomic(
                scenario,
                component.get('players') if component else (top_params.get('players') if scenario_name == name else None),
                component.get('parameters', {}) if component else (
                    {key: value for key, value in top_params.items() if key != 'players'} if scenario_name == name else {}
                ),
            )
            return
        if component and ('players' in component or component.get('parameters')):
            raise BenchmarkError(
                f'Composite scenario {scenario_name!r} cannot be resized/parameterized as a component; '
                'configure its child components instead'
            )
        for child in scenario['components']:
            expand(child['scenario'], child, (*stack, scenario_name))

    expand(name)
    return selected, top_params, plan
