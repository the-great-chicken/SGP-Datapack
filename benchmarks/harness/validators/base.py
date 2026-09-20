"""Scenario-specific semantic validation hooks.

The runner knows only this lifecycle. Scenario JSON selects validators by name,
so adding a new scenario invariant does not add scenario branches to runner.py.
"""
from __future__ import annotations

from abc import ABC
from collections.abc import Iterable
from typing import Any

from ..errors import BenchmarkError


class ScenarioValidator(ABC):
    name: str

    def validate_live(self, server, plan, *, after_reset: bool = False) -> dict:
        return {}

    def wait_measurement_ready(self, server, plan, *, timeout: float) -> None:
        return None

    def validate_profile(self, run: dict, plan, live_validation: dict) -> dict:
        return {}

    def validate_persisted(self, run: dict, plan) -> dict:
        return {}


def registry() -> dict[str, ScenarioValidator]:
    # Local imports keep implementations independent from registry initialization
    # and avoid import cycles through runtime helpers.
    from .bats import VALIDATOR as bats
    from .diorama import VALIDATOR as diorama
    from .rays import VALIDATOR as rays

    return {validator.name: validator for validator in (rays, diorama, bats)}


def validator_names_for_plan(plan) -> list[str]:
    """Return validator declarations carried by a freshly resolved plan."""
    names: list[str] = []
    for component in plan:
        configured = getattr(component, 'validators', None)
        if configured is None and isinstance(component, dict):
            configured = component.get('validators', ())
        for name in configured or ():
            if name not in names:
                names.append(name)
    return names


def _historical_validator_names(plan) -> list[str]:
    """Recover validators for result metadata written before validator names were recorded."""
    return [
        validator.name
        for validator in registry().values()
        if validator.matches_legacy_plan(plan)
    ]


def validators_for_names(names: Iterable[str]) -> list[ScenarioValidator]:
    known = registry()
    resolved = []
    for name in names:
        try:
            resolved.append(known[name])
        except KeyError as exc:
            raise BenchmarkError(f'Unknown benchmark scenario validator {name!r}') from exc
    return resolved


def validators_for_plan(plan) -> list[ScenarioValidator]:
    return validators_for_names(validator_names_for_plan(plan))


def _merge_validation(target: dict[str, Any], values: dict, validator: ScenarioValidator) -> None:
    overlap = target.keys() & values.keys()
    if overlap:
        raise BenchmarkError(
            f'Validator {validator.name!r} produced fields already owned by another validator: {sorted(overlap)}'
        )
    target.update(values)


def run_live_validators(server, plan, *, validators: list[ScenarioValidator] | None = None,
                        after_reset: bool = False) -> dict:
    validated: dict[str, Any] = {}
    for validator in validators if validators is not None else validators_for_plan(plan):
        _merge_validation(
            validated,
            validator.validate_live(server, plan, after_reset=after_reset),
            validator,
        )
    return validated


def wait_measurement_validators(server, plan, *, timeout: float,
                                validators: list[ScenarioValidator] | None = None) -> None:
    for validator in validators if validators is not None else validators_for_plan(plan):
        validator.wait_measurement_ready(server, plan, timeout=timeout)


def run_profile_validators(run: dict, plan, live_validation: dict, *,
                           validators: list[ScenarioValidator] | None = None) -> dict:
    validated: dict[str, Any] = {}
    for validator in validators if validators is not None else validators_for_plan(plan):
        _merge_validation(
            validated,
            validator.validate_profile(run, plan, live_validation),
            validator,
        )
    return validated


def validate_persisted_run(run: dict, plan, validator_names: list[str] | None = None) -> None:
    names = _historical_validator_names(plan) if validator_names is None else validator_names
    for validator in validators_for_names(names):
        validator.validate_persisted(run, plan)
