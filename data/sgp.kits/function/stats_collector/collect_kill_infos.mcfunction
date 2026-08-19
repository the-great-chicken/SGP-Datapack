#> sgp.kits:stats_collector/collect_kill_infos
#
# Find out who killed the player, and what kit they were both wearing.

execute store result storage sgp:macro stats.current_kill_info.kit_id_victim int 1 \
    run scoreboard players get @s sgp.kit_id

execute store result storage sgp:macro stats.current_kill_info.id_victim int 1 \
    run scoreboard players get @s sgp.id


data modify storage sgp:macro stats.current_kill_info.id_killer set value -1
data modify storage sgp:macro stats.current_kill_info.kit_id_killer set value -1


execute on attacker \
    store result storage sgp:macro stats.current_kill_info.kit_id_killer int 1 \
        run scoreboard players get @s sgp.kit_id

execute on attacker \
    store result storage sgp:macro stats.current_kill_info.id_killer int 1 \
        run scoreboard players get @s sgp.id


function sgp.kits:stats_collector/save_kill_stat with storage sgp:macro stats.current_kill_info
function sgp.kits:stats_collector/save_pick_infos with storage sgp:macro stats.current_kill_info