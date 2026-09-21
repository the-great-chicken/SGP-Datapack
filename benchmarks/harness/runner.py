"""Execution lifecycle for one benchmark invocation."""
from __future__ import annotations

from datetime import datetime
import json
import sys

from .diagnostics import copy_if_file, mark_success, write_failure_bundle
from .errors import BenchmarkError, BenchmarkInvalidError
from .gc_log import parse_gc_log, summarize_gc
from .models import ParsedProfile
from .profiler import format_number, parse_profile, profile_to_dict, wait_for_new_profile
from .reporting import git_commit, git_dirty, source_fingerprint, write_summary
from .runtime import (compile_active_plan, compile_actor_pool, plan_total_players,
                      read_workload_counters, require_actor_in_game,
                      wait_for_actor_chunks_loaded)
from .scenarios import load_scenarios, resolve_plan
from .server import ServerProcess
from .settings import CONFIG, INVALID_MARKER, SERVER_MARKER
from .staging import prepare_server
from .validators import (run_live_validators, run_profile_validators,
                         validators_for_plan, wait_measurement_validators)

# PackTest dummy players never drain the packets sent to them, so a heavy scenario
# keeps most of what it allocated alive for the whole session. Above this share of
# the heap the next run would start GC-bound, so the JVM is restarted first.
RETAINED_HEAP_RESTART_FRACTION = 0.5


def _heap_retained(profile: ParsedProfile) -> bool:
    heap_after, capacity = profile.gc_heap_after_mb, profile.gc_heap_capacity_mb
    return bool(heap_after and capacity and heap_after > RETAINED_HEAP_RESTART_FRACTION * capacity)


def _boot_server(server: ServerProcess, args, set_phase) -> None:
    """Start the JVM, pin the command limit and (re)build the fixture; also used mid-session."""
    set_phase('starting Minecraft server')
    print('Starting Minecraft server ...')
    server.start(timeout=args.startup_timeout)

    set_phase('setting benchmark command limit')
    server.send(f'gamerule minecraft:max_command_sequence_length {args.command_limit}')
    server.send('execute store result score #command_limit sgp.bench run gamerule minecraft:max_command_sequence_length')
    server.require_score('#command_limit', args.command_limit)

    set_phase('creating benchmark fixture')
    print('Server ready; creating benchmark fixture.')
    server.send('function sgp.bench:fixture/setup')
    server.require_score('#fixture_ready', 1)


def _run_benchmark_once(args, *, announce_result: bool = True, announce_failure: bool = True):
    scenarios = load_scenarios()
    scenario, params, plan = resolve_plan(scenarios, args.scenario, args.players, args.param)
    total_players = plan_total_players(plan)
    validators = validators_for_plan(plan)
    validator_names = [validator.name for validator in validators]
    plan_data = [component.as_dict() for component in plan]
    server_dir = args.server_dir.resolve()
    cache_dir = args.cache_dir.resolve()
    results_root = args.results_dir.resolve()

    timestamp = datetime.now().strftime('%Y-%m-%d_%H.%M.%S.%f')[:-3]
    suffix = f'players-{total_players}'
    result_dir = results_root / f'{timestamp}_{scenario["name"]}_{suffix}'
    result_dir.mkdir(parents=True, exist_ok=False)

    metadata = {
        'created_at': datetime.now().astimezone().isoformat(),
        'status': 'running',
        'scenario': scenario['name'],
        'description': scenario['description'],
        'parameters': params,
        'total_players': total_players,
        'plan': plan_data,
        'validators': validator_names,
        'runs': args.runs,
        'warmup_seconds': args.warmup,
        'minecraft_version': CONFIG['minecraft_version'],
        'java_expected': CONFIG['java_version'],
        'heap': args.heap,
        'command_limit': args.command_limit,
        'command_limit_mode': getattr(args, 'command_limit_mode', 'explicit'),
        'git_commit': git_commit(),
        'git_dirty': git_dirty(),
        'source_sha256': source_fingerprint(),
    }
    calibration = getattr(args, 'command_limit_calibration', None)
    if calibration is not None:
        metadata['command_limit_calibration'] = calibration
    (result_dir / 'metadata.json').write_text(json.dumps(metadata, indent=2) + '\n', encoding='utf-8')

    server: ServerProcess | None = None
    profiles: list[ParsedProfile] = []
    counters: list[dict] = []
    phase = 'preparing benchmark server'

    def set_phase(value: str) -> None:
        nonlocal phase
        phase = value

    try:
        if not args.reuse_server:
            prepare_server(server_dir, cache_dir)
        elif not (server_dir / SERVER_MARKER).is_file() or not (server_dir / 'server.jar').is_file():
            raise BenchmarkError(f'--reuse-server was requested but {server_dir} is not prepared')
        elif (server_dir / INVALID_MARKER).exists():
            raise BenchmarkInvalidError('Refusing to reuse an interrupted benchmark world; omit --reuse-server')

        phase = 'compiling benchmark runtime'
        compile_actor_pool(server_dir, total_players)
        compile_active_plan(server_dir, plan)

        server = ServerProcess(server_dir, args.java, args.heap)
        _boot_server(server, args, set_phase)

        for run_number in range(1, args.runs + 1):
            phase = f'run {run_number}/{args.runs} setup'
            print(f'Run {run_number}/{args.runs}: setup')
            server.send(f'function sgp.bench:prepare {{players:{total_players}}}')
            server.send('execute store result score #actual_players sgp.bench if entity @a[tag=sgp.bench.actor]')
            server.require_score('#players', total_players)
            server.require_score('#actual_players', total_players)
            wait_for_actor_chunks_loaded(server, total_players, args.startup_timeout)
            server.send('function sgp.bench:generated/active/setup')
            server.require_score('#plan_ready', 1)
            require_actor_in_game(server, total_players)
            run_live_validators(server, plan, validators=validators)
            server.send('function sgp.bench:start')
            server.require_score('#enabled', 1)

            phase = f'run {run_number}/{args.runs} warm-up'
            server.sleep_alive(args.warmup)
            require_actor_in_game(server, total_players)
            run_live_validators(server, plan, validators=validators)

            phase = f'run {run_number}/{args.runs} profiling'
            # Scenario-specific preparation can quiesce warm-up state without
            # resetting the actual measurement phase. This matters for living
            # entities such as bats: /kill starts a death lifecycle rather than
            # removing them immediately.
            server.send('function sgp.bench:generated/active/measurement_prepare')
            wait_measurement_validators(
                server, plan, timeout=args.startup_timeout, validators=validators
            )
            server.send('function sgp.bench:measurement_reset')
            profile_dir = server_dir / 'debug/profiling'
            previous = {path.resolve() for path in profile_dir.glob('*.zip')} if profile_dir.is_dir() else set()
            print(f'Run {run_number}/{args.runs}: /perf')
            perf_started_at = datetime.now().astimezone()
            server.send('perf start')
            # Preserve the raw profile as part of the wait itself. Minecraft writes
            # profiling archives asynchronously and, on Windows, a just-validated
            # source path can briefly disappear before a separate copy operation.
            destination = result_dir / f'run-{run_number:02d}.zip'
            wait_for_new_profile(
                server_dir, previous, server, timeout=args.profile_timeout, destination=destination
            )
            perf_ended_at = datetime.now().astimezone()
            server.send('scoreboard players set #enabled sgp.bench 0')

            server.send('execute store result score #actual_players sgp.bench if entity @a[tag=sgp.bench.actor]')
            server.require_score('#actual_players', total_players)
            require_actor_in_game(server, total_players)
            live_validation = run_live_validators(server, plan, validators=validators)
            workload = read_workload_counters(server, plan)
            missing_counters = [name for name, value in workload.items() if value is None]
            if missing_counters:
                raise BenchmarkError(
                    f'Workload counters were not readable after profiling: {", ".join(missing_counters)}'
                )
            count = {
                'ticks': server.score('#ticks'),
                'workload': workload,
            }
            counters.append(count)

            phase = f'run {run_number}/{args.runs} parsing profile'
            parsed = parse_profile(destination)
            parsed.gc = summarize_gc(parse_gc_log(server.gc_log), perf_started_at, perf_ended_at, parsed.tick_span)
            run_data = profile_to_dict(parsed, count)
            (result_dir / f'run-{run_number:02d}.json').write_text(
                json.dumps(run_data, indent=2) + '\n', encoding='utf-8'
            )
            phase = f'run {run_number}/{args.runs} validating completed workload'
            validated = run_profile_validators(run_data, plan, live_validation, validators=validators)
            if validated:
                run_data['validated_workload'] = validated
                (result_dir / f'run-{run_number:02d}.json').write_text(
                    json.dumps(run_data, indent=2) + '\n', encoding='utf-8'
                )
                print(f'Run {run_number}/{args.runs}: verified workload {validated}')
            profiles.append(parsed)
            print(
                f'Run {run_number}/{args.runs}: captured {parsed.tick_span or "?"} ticks, '
                f'mean MSPT={format_number(parsed.mean_mspt_ms, 3)} ms, '
                f'commandFunctions={format_number(parsed.command_functions_percent)}% '
                f'({format_number(parsed.command_functions_ms_per_tick, 3)} ms/tick, '
                f'{format_number(parsed.commands_executed_per_tick, 0)} commands/tick), '
                f'entities={format_number(parsed.entities_ms_per_tick, 3)} ms/tick, '
                f'tick period median={format_number(parsed.tick_period_median_ms, 3)} ms, '
                f'GC pauses={parsed.gc["pauses"]} ({format_number(parsed.gc_ms_per_tick, 3)} ms/tick), '
                f'heap after GC={format_number(parsed.gc_heap_after_mb, 0)} MB'
            )

            phase = f'run {run_number}/{args.runs} teardown'
            server.send('function sgp.bench:reset')
            server.sleep_alive(0.5)
            server.require_score('#plan_ready', 0)
            server.require_score('#players', 0)
            run_live_validators(server, plan, validators=validators, after_reset=True)

            if run_number < args.runs and _heap_retained(parsed):
                print(
                    f'Run {run_number}/{args.runs}: {parsed.gc_heap_after_mb:.0f} MB of the '
                    f'{parsed.gc_heap_capacity_mb:.0f} MB heap is still live after GC; restarting the JVM so '
                    f'run {run_number + 1} does not start GC-bound (PackTest dummies never drain their packets).'
                )
                phase = f'run {run_number}/{args.runs} JVM restart'
                server.stop()
                _boot_server(server, args, set_phase)
                metadata.setdefault('jvm_restarts_before_runs', []).append(run_number + 1)
                (result_dir / 'metadata.json').write_text(json.dumps(metadata, indent=2) + '\n', encoding='utf-8')

        if not profiles:
            raise BenchmarkError('No profiles were captured')
        phase = 'stopping Minecraft server'
        server.stop()
        server.check_health()
        copy_if_file(server_dir / 'benchmark-console.log', result_dir / 'diagnostics/benchmark-console.log')
        phase = 'writing summary'
        write_summary(result_dir, scenario, params, args.warmup, profiles, counters, plan=plan,
                      command_limit=args.command_limit, command_limit_calibration=calibration,
                      metadata=metadata)
        mark_success(result_dir, metadata)
    except Exception as exc:
        stop_error = None
        if server is not None:
            try:
                server.stop()
            except Exception as stop_exc:  # Diagnostics should survive teardown failures too.
                stop_error = stop_exc
        write_failure_bundle(result_dir, metadata, phase, exc, server_dir, server, plan)
        if isinstance(exc, BenchmarkInvalidError) and (server_dir / SERVER_MARKER).is_file():
            (server_dir / INVALID_MARKER).write_text(str(exc) + '\n', encoding='utf-8')
        if stop_error is not None:
            (result_dir / 'diagnostics/server-stop-error.txt').write_text(
                f'{type(stop_error).__name__}: {stop_error}\n', encoding='utf-8'
            )
        if announce_failure:
            print(f'Failure diagnostics: {result_dir}', file=sys.stderr)
        raise

    if announce_result:
        print(f'\nResults: {result_dir}')
        print(f'Summary: {result_dir / "summary.md"}')
    return result_dir
