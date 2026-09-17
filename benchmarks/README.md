# SGP local performance benchmarks

This harness benchmarks **datapack CPU work** on a local Fabric server using PackTest fake players and vanilla `/perf`. It stages the plugin-free production core without PackTest unit-test fixtures or coverage instrumentation.

It intentionally does not model Paper plugins, networking, Carpet, spark, CI performance gates, or production hardware.

## Requirements

- Python 3.11+
- Java 25 available as `java`
- Internet access on the first run; dependencies are cached in `.bench-cache/`

## Run

From the repository root:

```bash
python benchmarks/bench.py list
python benchmarks/bench.py run idle --players 40 --runs 5
python benchmarks/bench.py run ability_cleave --players 40 --param period=20 --runs 5
python benchmarks/bench.py run idle_cleave --runs 5
```

A normal `run` rebuilds `.packtest-bench-server/` from the current source. Use `--reuse-server` only while debugging the harness.

Each repetition does: reset/setup -> workload warm-up (default 5 s) -> counter reset -> `/perf` -> raw-profile capture -> teardown. Repetitions reuse one freshly created server/JVM.

Results go to `benchmarks/results/<timestamp>_<scenario>_players-N/`:

- `run-NN.zip`: untouched vanilla `/perf` archive;
- `run-NN.json`: parsed tick-time statistics, `commandFunctions` data, and workload counters;
- `metadata.json`: scenario plan, versions, git commit when available, and source SHA-256;
- `summary.md`: aggregate/per-run metrics and hottest `commandFunctions` entries.

Tick-time statistics come from `server/metrics/ticking.csv`; `profiling.txt` supplies function attribution.

If a run fails, the result directory is kept instead of discarded. It contains `failure.md`, `failure.json`, and a `diagnostics/` directory with the server console/latest log and generated active scenario functions when available. Start there when a fixture or workload state check fails.

## Compose workloads in JSON

Atomic scenarios define setup/tick/teardown functions. Composite scenarios are **JSON only**: they reference atomic or other composite scenarios and assign player counts/parameter overrides. No Python or mcfunction needs to be written just to combine existing workloads.

For example, `benchmarks/scenarios/idle_cleave.json` is:

```json
{
  "name": "idle_cleave",
  "description": "Composition example: 20 initialized idle players plus 20 Combattant players repeatedly using Cleave.",
  "components": [
    {"scenario": "idle", "players": 20},
    {"scenario": "ability_cleave", "players": 20, "parameters": {"period": 20}}
  ]
}
```

The runner flattens the composition, allocates each component a contiguous non-overlapping slice of the `Bench01`..`Bench40` actor pool, and generates the active setup/tick/teardown dispatcher for that invocation. Nested compositions are supported. The resolved plan is recorded in `metadata.json` and `summary.md`.

The total resolved player count may not exceed 40. Composite counts and parameters currently come from their JSON; `--players` and `--param` apply to atomic scenarios only.

## Included atomic scenarios

### `idle`

Creates 0-40 initialized players inside the synthetic PvP arena and generates no benchmark actions. This measures the datapack's player-count-dependent idle cost.

### `ability_cleave`

Gives the selected actors Combattant. Every `period` ticks, each actor uses PackTest's real drop interaction and production code routes that input into Cleave. The default period is 20 ticks.

`idle_cleave` is only a composition example; it has no scenario-specific mcfunctions.

## Add an atomic scenario

Add `benchmarks/scenarios/<name>.json` with `setup`, `tick`, `teardown`, and integer `parameters` (including `players`), then put benchmark-only mcfunctions under `benchmarks/fixtures/data/sgp.bench/function/scenarios/<name>/`.

Each atomic component receives these macro arguments:

- `first`: first actor index assigned to the component;
- `last`: last actor index;
- `players`: component actor count;
- all scenario-specific integer parameters.

Actors have their stable index in objective `sgp.bench`, so a component should restrict itself to `scores={sgp.bench=$(first)..$(last)}`. This is what makes multiple atomic workloads composable without hard-coded player names/ranges.

The common reset clears `Bench01`..`Bench40` scoreboard values, removes their Actionbar Mixer registration before disconnect, and removes the benchmark-created stats rows. A scenario that mutates other persistent storage must undo it in its own teardown.

Prefer putting actors into states that make **production code** expensive. Avoid high-frequency artificial movement/teleport commands unless that input itself is what you want to benchmark, because benchmark commands are profiled too.

## Compare changes

Run the same scenario before and after an optimization:

```bash
python benchmarks/bench.py compare benchmarks/results/BEFORE benchmarks/results/AFTER
```

The comparison verifies the resolved workload plan by default, then compares median tick times, `commandFunctions` load, workload counts, and per-entry profiler changes. `--allow-mismatch` exists for deliberate cross-scenario comparisons.

You can also inspect arbitrary `/perf` archives:

```bash
python benchmarks/bench.py parse path/to/profile.zip --top 30
```

## Harness self-test

These tests do not start Minecraft:

```bash
python benchmarks/test_bench.py
python .github/scripts/test_ci_staging.py
```
