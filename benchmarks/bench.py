#!/usr/bin/env python3
"""Local SGP datapack benchmark runner.

This module is intentionally a thin CLI/compatibility facade. Implementation
lives in benchmarks.harness, split by responsibility.
"""
from __future__ import annotations

from pathlib import Path
import argparse
import importlib.util
import sys

ROOT = Path(__file__).resolve().parent.parent
if str(ROOT) not in sys.path:
    sys.path.insert(0, str(ROOT))

from benchmarks.harness.calibration import run_benchmark
from benchmarks.harness.cli import (
    build_parser,
    command_limit_argument,
    list_scenarios,
    main,
    prepare_command,
)
from benchmarks.harness.comparison import (
    compare_results,
    entry_medians,
    load_result_directory,
    nested_numeric_median,
    numeric_median,
    relative_change,
    upgrade_run,
    validated_workload_medians,
    workload_counter_medians,
)
from benchmarks.harness.diagnostics import copy_if_file, mark_success, write_failure_bundle
from benchmarks.harness.errors import BenchmarkError, BenchmarkInvalidError, CommandLimitError
from benchmarks.harness.models import ParsedProfile, PlanComponent, ProfileEntry, percentile
from benchmarks.harness.profiler import (
    FUNCTION_CALL,
    PROFILE_LINE,
    TICK_SPAN,
    TIME_SPAN,
    VERSION,
    benchmark_source_files,
    build_source_index,
    format_number,
    logical_commands,
    parse_archives,
    parse_profile,
    profile_to_dict,
    source_hint,
    wait_for_new_profile,
)
from benchmarks.harness.reporting import (
    command_limit_summary,
    describe_source,
    git_commit,
    git_dirty,
    source_fingerprint,
    write_summary,
)
from benchmarks.harness.runner import _run_benchmark_once
from benchmarks.harness.runtime import (
    actor_chunk_probe_positions,
    actor_name,
    actor_position,
    compile_active_plan,
    compile_actor_pool,
    plan_counter_specs,
    plan_function_call,
    plan_total_players,
    previous_actor_count,
    read_workload_counters,
    set_server_property,
    wait_for_actor_chunks_loaded,
)
from benchmarks.harness.scenarios import (
    load_scenarios,
    parameter_default,
    parameter_values,
    parse_raw_params,
    resolve_plan,
    validate_parameter_specs,
    validate_parameters,
    validate_scenario_graph,
)
from benchmarks.harness.server import ServerProcess
from benchmarks.harness.settings import (
    BENCHMARKS,
    COMMAND_LIMIT_TOLERANCE,
    CONFIG,
    DEFAULT_CACHE,
    DEFAULT_COMMAND_LIMIT,
    DEFAULT_RESULTS,
    DEFAULT_SERVER,
    INVALID_MARKER,
    MAX_COMMAND_LIMIT,
    SERVER_MARKER,
)
from benchmarks.harness.staging import cached_download, prepare_server, verify_zip
from benchmarks.harness.suites import (
    case_slug,
    expand_suite_cases,
    load_suite,
    result_summary_metrics,
    run_suite,
    write_suite_summary,
)
from benchmarks.harness.validators import persisted_validators, validate_persisted_run
from benchmarks.harness.validators.bats import (
    WORKLOAD_CONSTANTS as BATS_WORKLOAD_CONSTANTS,
    bats_actor_ranges,
    bats_player_count,
    require_bat_targets,
    stored_workload_constants,
    validate_bats_profile,
    wait_for_bat_cleanup,
    validate_bats_workload,
)
from benchmarks.harness.validators.diorama import require_diorama_entities, validate_diorama_workload
from benchmarks.harness.validators.rays import (
    ray_actor_indices,
    ray_actor_ranges,
    ray_player_count,
    require_ray_entities,
    validate_ray_workload,
)


def load_module(path: Path, name: str):
    """Legacy helper kept for callers that imported it from the old monolith."""
    spec = importlib.util.spec_from_file_location(name, path)
    if spec is None or spec.loader is None:
        raise BenchmarkError(f'Could not load {path}')
    module = importlib.util.module_from_spec(spec)
    sys.modules[name] = module
    try:
        spec.loader.exec_module(module)
    except Exception:
        sys.modules.pop(name, None)
        raise
    return module


if __name__ == '__main__':
    raise SystemExit(main())
