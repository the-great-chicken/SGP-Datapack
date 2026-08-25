#> sgp.kits:stats_collector/collect_kit_pick_infos

execute unless function sgp.kits:stats_collector/can_collect run return 0

execute store result storage sgp:macro stats.current_kit_pick_info.player_id int 1 \
    run scoreboard players get @s sgp.id

execute store result storage sgp:macro stats.current_kit_pick_info.kit_id int 1 \
    run scoreboard players get @s sgp.kit_id

execute store result storage sgp:macro stats.current_kit_pick_info.pick_time int 1 \
    run time query gametime

function sgp.kits:stats_collector/save_pick_start with storage sgp:macro stats.current_kit_pick_info
