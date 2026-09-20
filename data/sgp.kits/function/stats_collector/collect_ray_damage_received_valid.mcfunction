#> sgp.kits:stats_collector/collect_ray_damage_received_valid
#
# Fast path for a validated Rays damage event. Rays only target non-peaceful
# players other than the caster, and their damage source is always that caster.

scoreboard players operation #damage_received_delta sgp.dummy = @s sgp.damage_taken

data modify storage sgp:macro stats.current_damage_info set value {id_target:-1,kit_id_target:-1,id_source:-1,kit_id_source:-1,cause_id:102}

execute store result storage sgp:macro stats.current_damage_info.id_target int 1 \
    run scoreboard players get @s sgp.id

execute store result storage sgp:macro stats.current_damage_info.kit_id_target int 1 \
    run scoreboard players get @s sgp.kit_id

execute on attacker \
    store result storage sgp:macro stats.current_damage_info.id_source int 1 \
        run scoreboard players get @s sgp.id

execute on attacker \
    store result storage sgp:macro stats.current_damage_info.kit_id_source int 1 \
        run scoreboard players get @s sgp.kit_id

scoreboard players set #ray_ability_cast sgp.dummy 0
execute on attacker \
    if score @s sgp.ability_kind matches 6 \
    if score @s sgp.ability_cast matches 1.. \
    store result score #ray_ability_cast sgp.dummy \
        run scoreboard players get @s sgp.ability_cast
execute if score #ray_ability_cast sgp.dummy matches 1.. \
    run function sgp.kits:stats_collector/ability/mark_ray_affected

function sgp.kits:stats_collector/save_damage_received with storage sgp:macro stats.current_damage_info
