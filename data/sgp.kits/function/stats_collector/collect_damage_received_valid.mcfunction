#> sgp.kits:stats_collector/collect_damage_received_valid
#
# Capture the current event's damage, cause, and target/source player and kit ids.

scoreboard players operation #damage_received_delta sgp.dummy = @s sgp.damage_taken

data modify storage sgp:macro stats.current_damage_info set value {id_target:-1,kit_id_target:-1,id_source:-1,kit_id_source:-1,cause_id:0}

execute store result storage sgp:macro stats.current_damage_info.id_target int 1 \
    run scoreboard players get @s sgp.id

execute store result storage sgp:macro stats.current_damage_info.kit_id_target int 1 \
    run scoreboard players get @s sgp.kit_id

execute store result storage sgp:macro stats.current_damage_info.cause_id int 1 \
    run scoreboard players get @s sgp.death_cause

execute on attacker if entity @s[type=minecraft:player] \
    store result storage sgp:macro stats.current_damage_info.id_source int 1 \
        run scoreboard players get @s sgp.id

execute on attacker if entity @s[type=minecraft:player] \
    store result storage sgp:macro stats.current_damage_info.kit_id_source int 1 \
        run scoreboard players get @s sgp.kit_id

function sgp.kits:stats_collector/save_damage_received with storage sgp:macro stats.current_damage_info
