#> sgp.kits:stats_collector/pause_pick_as_player
#
# Executed as a current participant when a major event begins. The interrupted
# normal-play kit life is finalized before synthetic event cleanup runs.

execute store result storage sgp:macro stats.current_pick_pause.id_victim int 1 \
    run scoreboard players get @s sgp.id
execute store result storage sgp:macro stats.current_pick_pause.kit_id_victim int 1 \
    run scoreboard players get @s sgp.kit_id

function sgp.kits:stats_collector/save_pick_infos with storage sgp:macro stats.current_pick_pause
