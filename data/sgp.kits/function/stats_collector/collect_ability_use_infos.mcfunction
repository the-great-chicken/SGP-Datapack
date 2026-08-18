#> sgp.kits:stats_collector/collect_ability_use_infos

execute store result storage sgp:macro stats.current_ability_use_info.kit_id int 1 \
    run scoreboard players get @s sgp.kit_id

execute store result storage sgp:macro stats.current_ability_use_info.id int 1 \
    run scoreboard players get @s sgp.id

function sgp.kits:stats_collector/save_ability_use with storage sgp:macro stats.current_ability_use_info