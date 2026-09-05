#> sgp.kits:stats_collector/elo/apply_pending
#
# Apply this tick's net transfer and persist the final player-level values.

scoreboard players operation @s sgp.elo += @s sgp.elo_pending
scoreboard players set @s sgp.elo_pending 0

# Keep the sidebar score absent until this player has 30 rated encounters.
scoreboard players reset @s sgp.elo_display
execute if score @s sgp.elo_encounters matches 30.. run scoreboard players operation @s sgp.elo_display = @s sgp.elo
execute if score @s sgp.elo_encounters matches 30.. run scoreboard players operation @s sgp.elo_display /= 100 sgp.dummy
execute if score @s sgp.elo_encounters matches 30.. run scoreboard players set #elo_display_available sgp.dummy 1

execute store result storage sgp:macro stats.current_elo_player.id int 1 \
    run scoreboard players get @s sgp.id
function sgp.kits:stats_collector/elo/save_player with storage sgp:macro stats.current_elo_player

tag @s remove sgp.elo_touched
