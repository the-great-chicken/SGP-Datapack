# Local performance benchmarks

PackTest fake players generate datapack workloads and vanilla `/perf` records the profile.

## Run

Requires Python 3.13+ and Java 25. The first run downloads the pinned benchmark dependencies.

```bash
python benchmarks/bench.py list
python benchmarks/bench.py run idle --players 40 --runs 5
python benchmarks/bench.py run ability_cleave --players 40 --param period=20 --runs 5
python benchmarks/bench.py suite all_abilities
python benchmarks/bench.py run abilities_4_per_kit --runs 5
python benchmarks/bench.py suite basic_scaling
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


## Ability coverage

Every production kit ability has at least one atomic scenario under `benchmarks/scenarios/abilities/`. Expensive state-dependent paths have explicit variants rather than being hidden inside one ambiguous workload: Pecking has far-lock and full-miss cases; Assassinate has armed and triggered cases; Bats has sustained-swarm and detonation cases; Rays has raycast-only and dense-piercing cases; Fangs has flat and reusable rough-terrain cases. Bigger benchmarks repeated start/end lifecycle work, Water Trident fakes only the leave/re-entry state transition, Repulsion resets actors after its real displacement measurement, and `ability_cooldown` isolates the shared cooldown/input path.

`all_abilities` runs all of those ability workloads at 40 players each. `abilities_4_per_kit` remains a 48-player composition with four players on each of the twelve ability-bearing kits and selects the higher-load representative variant where one exists.

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
