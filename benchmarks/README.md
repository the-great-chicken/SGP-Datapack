# Local performance benchmarks

PackTest fake players generate datapack workloads and vanilla `/perf` records the profile.

## Run

Requires Python 3.12+ and Java 25. The first run downloads the pinned benchmark dependencies.

```bash
python benchmarks/bench.py list
python benchmarks/bench.py run idle --players 40 --runs 5
python benchmarks/bench.py run ability_cleave --players 40 --param period=20 --runs 5
python benchmarks/bench.py suite all_abilities
```

Results are written under `benchmarks/results/`. Failed runs keep diagnostics there as well.

## Metrics

- **Mean MSPT**: server work per tick, `Time span × tick% / Tick span` from the `/perf` root split
  (`tick` vs `nextTickWait`). This is the headline. It is `n/a` for results recorded before the
  harness stored that split.
- **Commands per tick**: datapack commands whose `execute` section ran, from the `/perf` command sections (`prepared` also counts lines whose conditions failed). Dispatch cost follows this count.
- **Entity ticking ms/tick**: the level `entities` section, outside command functions, with a per-type table (players, bats, TNT, items, displays...) so datapack-spawned entities are visible.
- **GC pauses ms/tick**: JVM stop-the-world pause time during the capture (from `-Xlog:gc`), which `/perf` attributes to whatever section was running. **Heap after GC** is the live heap after the last pause: PackTest dummy players never drain the packets sent to them, so heavy scenarios (rays) retain memory for the whole session and later runs of a session become GC-bound. When more than half the heap is still live after a run, the runner restarts the JVM before the next run (recorded in `metadata.json` and the summary); the GC ms/tick column shows what remains inside a run.
- **`commandFunctions` ms/tick**: absolute datapack cost per tick
  (`Time span × commandFunctions% / Tick span`). Comparable across runs even when TPS differs.
- **`commandFunctions` %**: share of the whole server loop, idle waiting included, so it shrinks
  whenever the server has spare time.
- **Tick period**: wall-clock interval between ticks from `metrics/ticking.csv`. It floors at 50 ms
  while the server keeps up, so its median/p95/max only reflect work once the server is saturated.
  Use p95/max for spike-heavy scenarios.
- `metadata.json` records `git_commit` and `git_dirty`; a run made from a dirty working tree is
  flagged in `summary.md` and in comparisons.

Without `--command-limit`, the runner starts at 65536. If the invocation hits only the command-sequence limit, it retries on fresh worlds, probes upward, and binary-searches until the passing limit is within 10% of the highest known failing value; it then reruns the requested benchmark at that limit. The selected value and calibration bounds are recorded in `summary.md` and `metadata.json`. Passing `--command-limit` disables auto-calibration. A limit failure cannot be auto-calibrated with `--reuse-server`, because an interrupted world is not safe to reuse.

## Compose scenarios

Scenarios live anywhere under `benchmarks/scenarios/`; discovery is recursive, so group larger families in subfolders such as `benchmarks/scenarios/abilities/` and `benchmarks/scenarios/combinations/`. Scenario names remain global and must be unique. Compose scenarios by referencing those names in JSON:

```json
{
  "name": "idle_cleave",
  "description": "20 idle players and 20 Cleave users.",
  "components": [
    {"scenario": "idle", "players": 20},
    {"scenario": "ability_cleave", "players": 20, "parameters": {"period": 20}}
  ]
}
```

## Suites

Suites in `benchmarks/suites/` expand matrices into benchmark runs. For example:

```json
{
  "name": "example",
  "description": "Example scaling suite.",
  "defaults": {"runs": 5, "warmup": 5},
  "benchmarks": [
    {"scenario": "idle", "matrix": {"players": [1, 10, 20, 40]}},
    {
      "scenario": "ability_cleave",
      "parameters": {"period": 20},
      "matrix": {"players": [1, 10, 20, 40]}
    }
  ]
}
```

Run a suite with `python benchmarks/bench.py suite <name-or-json-path>`. Its directory contains an aggregate `summary.md` and the individual case results.

## Add an atomic scenario

Define `setup`, `tick`, `teardown`, integer parameters, and optional counters in any JSON file below `benchmarks/scenarios/` whose filename matches the globally unique scenario name. Put its functions anywhere under `benchmarks/fixtures/data/sgp.bench/function/scenarios/` and reference them by resource location. Functions receive `first`, `last`, `players`, and scenario parameters.

Restrict the scenario to its assigned actors with:

```mcfunction
@a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}]
```

Benchmark actors must remain `sgp.in_game` throughout scenario setup, warm-up, and profiling. The generic runner validates this automatically. Scenario setup may reposition actors, but positions must remain inside the synthetic `pvp_arena` according to the same production arena-membership logic used during normal gameplay.

When a scenario moves an actor and then uses relative coordinates, remember that moving `@s` does not move the command execution position. Use `at @s` before later `~ ~ ~` coordinates when they are meant to be relative to the actor's new position.

Declare workload counters as score holders in the `sgp.bench` objective:

```json
"counters": {"activations": "#my_activations"}
```

They are reset before each `/perf` capture and included in summaries/comparisons.

### Scenario-specific validation

Keep scenario semantics out of the generic runner. If a workload needs live or post-profile integrity checks, declare a validator in the atomic scenario:

```json
"validators": ["rays"]
```

Implement the hook under `benchmarks/harness/validators/` and register it in `validators/base.py`. The runner only executes the generic validation lifecycle; it must not branch on scenario names. Most scenarios need no validator.

## Harness architecture

`benchmarks/bench.py` is only the stable CLI/compatibility facade. The implementation is split under `benchmarks/harness/` by responsibility: scenario resolution, staging, server control, runtime compilation, profiling, validation, calibration, reporting, comparison, and suites. Reusable repository staging lives under `sgp_tools/`; `.github/scripts/` are thin CLI wrappers around those modules.

## Compare or parse results

```bash
python benchmarks/bench.py compare benchmarks/results/BEFORE benchmarks/results/AFTER
python benchmarks/bench.py parse path/to/profile.zip --top 30
```
