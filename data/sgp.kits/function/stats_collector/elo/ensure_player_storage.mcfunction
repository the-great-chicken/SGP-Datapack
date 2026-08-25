#> sgp.kits:stats_collector/elo/ensure_player_storage
# `{id: player id}`

$execute if data storage sgp.kits:stats elo_ratings.$(id).rating \
    if data storage sgp.kits:stats elo_ratings.$(id).rated_encounters \
        run return run function sgp.kits:stats_collector/elo/load_player with storage sgp:macro stats.current_elo_player

scoreboard players set @s sgp.elo 100000
scoreboard players set @s sgp.elo_encounters 0
scoreboard players set @s sgp.elo_pending 0
function sgp.kits:stats_collector/elo/save_player with storage sgp:macro stats.current_elo_player
