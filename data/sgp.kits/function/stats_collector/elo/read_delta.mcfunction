#> sgp.kits:stats_collector/elo/read_delta
# `{index: 0..2642}`

$execute store result score #elo_delta sgp.dummy \
    run data get storage sgp.kits:runtime elo_delta_lookup[$(index)]
