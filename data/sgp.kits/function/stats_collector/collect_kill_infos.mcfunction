#> sgp.kits:stats_collector/collect_kill_infos
#
# Find out who killed the player, and what kit they were both wearing.

execute store result storage sgp:macro stats.current_kill_info.kit_id_victim int 1 \
    run scoreboard players get @s sgp.kit_id

execute on attacker \
    store result storage sgp:macro stats.current_kill_info.kit_id_killer int 1 \
        run scoreboard players get @s sgp.kit_id

execute on attacker \
    store result storage sgp:macro stats.current_kill_info.id_killer int 1 \
        run scoreboard players get @s sgp.id

# Only run if the player died to someone
execute on attacker \
    run function sgp.kits:stats_collector/save_kill_stat with storage sgp:macro stats.current_kill_info