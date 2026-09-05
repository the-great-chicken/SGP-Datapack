#> sgp.kits:stats_collector/elo/read_delta
# `{index: 0..4415, k: 18|30|50|80}`

$execute store result score #elo_favorite_delta sgp.dummy \
    run data get storage sgp.kits:runtime elo_delta_lookup.k$(k)[$(index)]
