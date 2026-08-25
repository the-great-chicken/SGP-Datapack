#> sgp.kits:stats_collector/elo/ensure_player
#
# Ensure the executing in-game player has runtime Elo scores.

execute unless entity @s[tag=sgp.in_game,scores={sgp.id=1..}] run return 0

execute if score @s sgp.elo = @s sgp.elo \
    if score @s sgp.elo_encounters = @s sgp.elo_encounters \
        run return 0

execute store result storage sgp:macro stats.current_elo_player.id int 1 \
    run scoreboard players get @s sgp.id
function sgp.kits:stats_collector/elo/ensure_player_storage with storage sgp:macro stats.current_elo_player
