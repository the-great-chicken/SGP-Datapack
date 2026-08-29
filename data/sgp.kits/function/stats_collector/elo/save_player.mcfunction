#> sgp.kits:stats_collector/elo/save_player
# `{id: player id}`

$execute store result storage sgp.kits:stats elo_ratings.$(id).rating int 1 \
    run scoreboard players get @s sgp.elo
$execute store result storage sgp.kits:stats elo_ratings.$(id).rated_encounters int 1 \
    run scoreboard players get @s sgp.elo_encounters
