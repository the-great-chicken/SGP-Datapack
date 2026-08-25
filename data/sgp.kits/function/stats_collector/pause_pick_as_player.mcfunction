#> sgp.kits:stats_collector/pause_pick_as_player
#
# Close the caller's active normal-play kit interval before sgp.kit_id changes.

execute unless score #stats_schema_version sgp.dummy matches 5 run return 0
execute unless score @s sgp.kit_id matches 0..11 run return 0

execute store result storage sgp:macro stats.current_pick_pause.id_victim int 1 \
    run scoreboard players get @s sgp.id
execute store result storage sgp:macro stats.current_pick_pause.kit_id_victim int 1 \
    run scoreboard players get @s sgp.kit_id

return run function sgp.kits:stats_collector/save_pick_infos with storage sgp:macro stats.current_pick_pause
