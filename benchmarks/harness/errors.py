"""Benchmark-specific exceptions."""

class BenchmarkError(RuntimeError):
    pass


class BenchmarkInvalidError(BenchmarkError):
    """The workload was interrupted or did not execute as requested."""


class CommandLimitError(BenchmarkInvalidError):
    """Minecraft stopped a command sequence because the configured limit was too low."""
