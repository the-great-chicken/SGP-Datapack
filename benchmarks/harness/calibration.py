"""Automatic Minecraft command-sequence-limit calibration."""
from __future__ import annotations

from pathlib import Path
import argparse
import shutil
import sys
import tempfile

from .errors import BenchmarkError, CommandLimitError
from .settings import COMMAND_LIMIT_TOLERANCE, DEFAULT_COMMAND_LIMIT, MAX_COMMAND_LIMIT

def _copy_args(args, **updates) -> argparse.Namespace:
    values = dict(vars(args))
    values.update(updates)
    return argparse.Namespace(**values)


def _attempt_result_dir(results_root: Path) -> Path | None:
    if not results_root.is_dir():
        return None
    candidates = [path for path in results_root.iterdir() if path.is_dir()]
    return max(candidates, key=lambda path: path.stat().st_mtime_ns) if candidates else None


def _promote_result(result_dir: Path, results_root: Path) -> Path:
    results_root = results_root.resolve()
    results_root.mkdir(parents=True, exist_ok=True)
    target = results_root / result_dir.name
    suffix = 2
    while target.exists():
        target = results_root / f'{result_dir.name}-{suffix}'
        suffix += 1
    shutil.move(str(result_dir), str(target))
    return target


def _calibration_gap_percent(failing: int, passing: int) -> float:
    return (passing - failing) * 100.0 / failing


from .runner import _run_benchmark_once

def run_benchmark(args):
    if args.command_limit is not None:
        explicit = _copy_args(
            args,
            command_limit_mode='explicit',
            command_limit_calibration=None,
        )
        return _run_benchmark_once(explicit)

    real_results_root = args.results_dir.resolve()
    real_results_root.mkdir(parents=True, exist_ok=True)
    trials: list[dict] = []
    attempt_number = 0

    # Keep temporary profiles on the same filesystem as the final results so a
    # successful invocation can be promoted with a rename instead of copying zips.
    with tempfile.TemporaryDirectory(prefix='.sgp-command-limit-', dir=real_results_root) as temporary:
        temporary_root = Path(temporary)

        def attempt(limit: int, runs: int, purpose: str, *, reuse_server: bool,
                    calibration: dict | None = None) -> tuple[bool, Path | None, CommandLimitError | None]:
            nonlocal attempt_number
            attempt_number += 1
            trial_root = temporary_root / f'{attempt_number:02d}_{purpose}_{limit}'
            trial_args = _copy_args(
                args,
                runs=runs,
                command_limit=limit,
                command_limit_mode='auto',
                command_limit_calibration=calibration,
                results_dir=trial_root,
                reuse_server=reuse_server,
            )
            if purpose == 'probe':
                print(f'Command-limit calibration: trying {limit} ...')
            try:
                result_dir = _run_benchmark_once(
                    trial_args, announce_result=False, announce_failure=False
                )
            except CommandLimitError as exc:
                trials.append({'limit': limit, 'runs': runs, 'purpose': purpose, 'status': 'failed'})
                return False, _attempt_result_dir(trial_root), exc
            except Exception:
                failed_dir = _attempt_result_dir(trial_root)
                if failed_dir is not None:
                    promoted = _promote_result(failed_dir, real_results_root)
                    print(f'Failure diagnostics: {promoted}', file=sys.stderr)
                raise
            trials.append({'limit': limit, 'runs': runs, 'purpose': purpose, 'status': 'passed'})
            return True, result_dir, None

        initial_calibration = {
            'initial_limit': DEFAULT_COMMAND_LIMIT,
            'selected_limit': DEFAULT_COMMAND_LIMIT,
            'calibrated': False,
        }
        passed, result_dir, limit_error = attempt(
            DEFAULT_COMMAND_LIMIT,
            args.runs,
            'initial',
            reuse_server=args.reuse_server,
            calibration=initial_calibration,
        )
        if passed:
            assert result_dir is not None
            promoted = _promote_result(result_dir, real_results_root)
            print(f'\nResults: {promoted}')
            print(f'Summary: {promoted / "summary.md"}')
            return promoted

        if args.reuse_server:
            if result_dir is not None:
                promoted = _promote_result(result_dir, real_results_root)
                print(f'Failure diagnostics: {promoted}', file=sys.stderr)
            raise BenchmarkError(
                'Automatic command-limit calibration requires fresh worlds after a limit failure. '
                'Rerun without --reuse-server, or pass an explicit --command-limit.'
            ) from limit_error

        print(
            f'Default command sequence limit {DEFAULT_COMMAND_LIMIT} was exceeded; '
            'calibrating on fresh benchmark worlds.'
        )
        known_failure = DEFAULT_COMMAND_LIMIT

        def probe(limit: int) -> bool:
            passed_probe, _result, _error = attempt(
                limit, 1, 'probe', reuse_server=False, calibration=None
            )
            return passed_probe

        def find_passing_bound(failing: int) -> tuple[int, int]:
            passing = min(failing * 2, MAX_COMMAND_LIMIT)
            if passing <= failing:
                raise BenchmarkError(
                    f'Benchmark still exceeds Minecraft command sequence limit {MAX_COMMAND_LIMIT}; '
                    'cannot calibrate a passing value.'
                )
            while not probe(passing):
                failing = passing
                if passing == MAX_COMMAND_LIMIT:
                    raise BenchmarkError(
                        f'Benchmark still exceeds Minecraft command sequence limit {MAX_COMMAND_LIMIT}; '
                        'cannot calibrate a passing value.'
                    )
                passing = min(passing * 2, MAX_COMMAND_LIMIT)

            while (
                passing - failing > 1
                and _calibration_gap_percent(failing, passing) > COMMAND_LIMIT_TOLERANCE * 100.0
            ):
                candidate = (failing + passing) // 2
                if probe(candidate):
                    passing = candidate
                else:
                    failing = candidate
            return failing, passing

        while True:
            known_failure, selected = find_passing_bound(known_failure)
            gap = _calibration_gap_percent(known_failure, selected)
            calibration = {
                'initial_limit': DEFAULT_COMMAND_LIMIT,
                'selected_limit': selected,
                'known_failing_limit': known_failure,
                'relative_gap_percent': gap,
                'calibrated': True,
                'probe_runs': 1,
                'trials': list(trials),
            }
            print(
                f'Command-limit calibration: selected {selected}; known failure {known_failure} '
                f'({gap:.2f}% pass/fail gap). Running the requested {args.runs} run(s) from a fresh world.'
            )
            passed, result_dir, _limit_error = attempt(
                selected,
                args.runs,
                'final',
                reuse_server=False,
                calibration=calibration,
            )
            if passed:
                assert result_dir is not None
                promoted = _promote_result(result_dir, real_results_root)
                print(f'\nResults: {promoted}')
                print(f'Summary: {promoted / "summary.md"}')
                return promoted

            # A one-run probe can miss a heavier tick that occurs in a longer invocation.
            # Treat the full-run failure as a new lower bound and continue upward.
            known_failure = selected
            print(
                f'Command-limit calibration: {selected} still failed during the full invocation; '
                'continuing above that value.'
            )
