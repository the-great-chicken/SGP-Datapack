#> sgp.kits:stats_collector/elo/apply_pending
#
# Apply this tick's net transfer and persist the final player-level values.

scoreboard players operation @s sgp.elo += @s sgp.elo_pending
scoreboard players set @s sgp.elo_pending 0

execute store result storage sgp:macro stats.current_elo_player.id int 1 \
    run scoreboard players get @s sgp.id
function sgp.kits:stats_collector/elo/save_player with storage sgp:macro stats.current_elo_player

tag @s remove sgp.elo_touched
