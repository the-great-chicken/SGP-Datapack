"""Dedicated Minecraft server process control."""
from __future__ import annotations

from pathlib import Path
import os
import re
import subprocess
import threading
import time

from .errors import BenchmarkError, BenchmarkInvalidError, CommandLimitError

# Written by the JVM in the server directory (relative: a drive letter would clash
# with -Xlog's option separator) and parsed per run by gc_log.py.
GC_LOG_NAME = 'gc.log'


class ServerProcess:
    def __init__(self, server: Path, java: str, heap: str):
        self.server = server
        self.java = java
        self.heap = heap
        self.gc_log = server / GC_LOG_NAME
        self.process: subprocess.Popen[str] | None = None
        self.lines: list[str] = []
        self._condition = threading.Condition()
        self._reader: threading.Thread | None = None
        self._log = None
        self._health_index = 0
        self._invalid_line: str | None = None

    def check_health(self):
        with self._condition:
            while self._health_index < len(self.lines):
                line = self.lines[self._health_index]
                self._health_index += 1
                if (
                    'Command execution stopped due to limit' in line
                    or 'Failed to load function ' in line
                    or 'Failed to load function tag ' in line
                ):
                    self._invalid_line = self._invalid_line or line
            if self._invalid_line is not None:
                if 'Command execution stopped due to limit' in self._invalid_line:
                    raise CommandLimitError(
                        f'Minecraft hit the command sequence limit: {self._invalid_line}\n'
                        'This world is invalid and must not be reused.'
                    )
                raise BenchmarkInvalidError(
                    f'Minecraft reported an invalid benchmark state: {self._invalid_line}\n'
                    'Fix the load error before benchmarking. Do not reuse the invalid world.'
                )

    def start(self, timeout: float = 120.0):
        if not (self.server / 'server.jar').is_file():
            raise BenchmarkError(f'Missing {self.server / "server.jar"}; prepare the server first')
        command = [
            self.java, f'-Xms{self.heap}', f'-Xmx{self.heap}',
            # GC pauses stall the server thread inside whatever /perf section was
            # running; the log lets every run report them (gc_log.py).
            f'-Xlog:gc:file={GC_LOG_NAME}:time,uptime:filecount=0',
            '-jar', 'server.jar', 'nogui',
        ]
        for stale in self.server.glob(f'{GC_LOG_NAME}*'):
            try:
                stale.unlink()
            except OSError:
                pass
        self._log = (self.server / 'benchmark-console.log').open('w', encoding='utf-8')
        try:
            self.process = subprocess.Popen(
                command,
                cwd=self.server,
                stdin=subprocess.PIPE,
                stdout=subprocess.PIPE,
                stderr=subprocess.STDOUT,
                text=True,
                encoding='utf-8',
                errors='replace',
                bufsize=1,
            )
        except FileNotFoundError as exc:
            self._close_log()
            raise BenchmarkError(f'Could not find Java executable {self.java!r}') from exc
        self._reader = threading.Thread(target=self._read_output, name='sgp-bench-server-log', daemon=True)
        self._reader.start()
        try:
            self.wait_for(lambda line: 'Done (' in line and 'For help, type' in line, timeout)
        except Exception as exc:
            try:
                self.stop()
            except Exception as stop_exc:
                exc.add_note(f'Additionally failed to stop Minecraft server: {stop_exc}')
            finally:
                # stop() only closes the console log when it completes. A failed
                # startup must never leave benchmark-console.log open: Windows
                # cannot delete an open file.
                self._close_log()
            raise

    def _close_log(self):
        log, self._log = self._log, None
        if log is not None and not log.closed:
            log.close()

    def _read_output(self):
        process, log = self.process, self._log
        assert process is not None and process.stdout is not None and log is not None
        for line in process.stdout:
            if log is not None:
                try:
                    log.write(line)
                    log.flush()
                except ValueError:
                    # Closed by a failed startup's cleanup; keep draining stdout.
                    log = None
            with self._condition:
                self.lines.append(line.rstrip('\n'))
                self._condition.notify_all()
        with self._condition:
            self._condition.notify_all()

    def wait_for(self, predicate, timeout: float, start_at: int = 0) -> str:
        deadline = time.monotonic() + timeout
        index = start_at
        while True:
            with self._condition:
                self.check_health()
                while index < len(self.lines):
                    line = self.lines[index]
                    index += 1
                    if predicate(line):
                        return line
                if self.process is not None and self.process.poll() is not None:
                    tail = '\n'.join(self.lines[-30:])
                    raise BenchmarkError(f'Minecraft server exited unexpectedly. Last output:\n{tail}')
                remaining = deadline - time.monotonic()
                if remaining <= 0:
                    tail = '\n'.join(self.lines[-30:])
                    raise BenchmarkError(f'Timed out waiting for server output. Last output:\n{tail}')
                self._condition.wait(min(remaining, 0.25))

    def send(self, command: str):
        if self.process is None or self.process.poll() is not None or self.process.stdin is None:
            raise BenchmarkError('Minecraft server is not running')
        self.process.stdin.write(command + '\n')
        self.process.stdin.flush()

    def sleep_alive(self, seconds: float):
        deadline = time.monotonic() + seconds
        self.check_health()
        while time.monotonic() < deadline:
            self.check_health()
            if self.process is None or self.process.poll() is not None:
                tail = '\n'.join(self.lines[-30:])
                raise BenchmarkError(f'Minecraft server exited unexpectedly. Last output:\n{tail}')
            time.sleep(min(0.2, deadline - time.monotonic()))
        self.check_health()

    def score(self, player: str, objective: str = 'sgp.bench', timeout: float = 5.0) -> int | None:
        before = len(self.lines)
        self.send(f'scoreboard players get {player} {objective}')
        # Minecraft prints the objective's display name in brackets, which may
        # differ from its internal command name (for example bs.id -> BS ID).
        pattern = re.compile(rf'(?:^|\s){re.escape(player)} has (-?\d+)(?:\s|$)')
        try:
            line = self.wait_for(lambda item: pattern.search(item) is not None, timeout, start_at=before)
        except BenchmarkInvalidError:
            raise
        except BenchmarkError:
            return None
        match = pattern.search(line)
        return int(match.group(1)) if match else None

    def require_score(self, player: str, expected: int, objective: str = 'sgp.bench') -> int:
        value = self.score(player, objective)
        if value != expected:
            raise BenchmarkError(
                f'Benchmark state check failed: expected {player} {objective}={expected}, got {value!r}'
            )
        return value

    def _force_stop(self, process: subprocess.Popen[str]):
        if os.name == 'nt':
            try:
                subprocess.run(
                    ['taskkill', '/PID', str(process.pid), '/T', '/F'],
                    stdout=subprocess.DEVNULL,
                    stderr=subprocess.DEVNULL,
                    check=False,
                    timeout=10,
                )
            except (OSError, subprocess.TimeoutExpired):
                pass
            try:
                process.wait(timeout=10)
                return
            except subprocess.TimeoutExpired:
                process.kill()
                try:
                    process.wait(timeout=5)
                    return
                except subprocess.TimeoutExpired as exc:
                    raise BenchmarkError(
                        f'Failed to stop Minecraft server process tree (PID {process.pid})'
                    ) from exc

        process.terminate()
        try:
            process.wait(timeout=10)
        except subprocess.TimeoutExpired:
            process.kill()
            try:
                process.wait(timeout=5)
            except subprocess.TimeoutExpired as exc:
                raise BenchmarkError(
                    f'Failed to stop Minecraft server process (PID {process.pid})'
                ) from exc

    def stop(self, force: bool = False):
        process = self.process
        if process is None:
            return

        if process.poll() is None and not force:
            try:
                self.send('stop')
                process.wait(timeout=30)
            except Exception:
                force = True

        if process.poll() is None and force:
            self._force_stop(process)

        if process.poll() is None:
            raise BenchmarkError(f'Minecraft server process is still running (PID {process.pid})')

        if self._reader is not None:
            self._reader.join(timeout=2)
        self._close_log()
        self.process = None
        self._reader = None
