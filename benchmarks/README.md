# Local performance benchmarks

PackTest fake players generate datapack workloads and vanilla `/perf` records the profile.

## Run

Requires Python 3.13+ and Java 25. The first run downloads the pinned benchmark dependencies.

```bash
python benchmarks/bench.py list
python benchmarks/bench.py run idle --players 40 --runs 5
python benchmarks/bench.py run ability_cleave --players 40 --param period=20 --runs 5
python benchmarks/bench.py suite all_abilities
```

Results are written under `benchmarks/results/`. Failed runs keep diagnostics there as well.

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

Declare workload counters as score holders in the `sgp.bench` objective:

```json
"counters": {"activations": "#my_activations"}
```

They are reset before each `/perf` capture and included in summaries/comparisons.

## Compare or parse results

```bash
python benchmarks/bench.py compare benchmarks/results/BEFORE benchmarks/results/AFTER
python benchmarks/bench.py parse path/to/profile.zip --top 30
```
