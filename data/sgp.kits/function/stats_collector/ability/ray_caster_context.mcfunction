#> sgp.kits:stats_collector/ability/ray_caster_context
#
# Executed as the Rays caster once per tick, right before its beams collide. The caster is the
# only possible attacker of every ray hit this tick, so the per-victim callbacks reuse these
# values instead of resolving the attacker again for each of the hits.

execute store result score #ray_stats sgp.dummy run function sgp.kits:stats_collector/can_collect
data modify storage sgp:macro stats.current_damage_info set value {id_target:-1,kit_id_target:-1,id_source:-1,kit_id_source:-1,cause_id:102}
execute store result storage sgp:macro stats.current_damage_info.id_source int 1 run scoreboard players get @s sgp.id
execute store result storage sgp:macro stats.current_damage_info.kit_id_source int 1 run scoreboard players get @s sgp.kit_id
scoreboard players set #ray_ability_cast sgp.dummy 0
execute if score @s sgp.ability_kind matches 6 if score @s sgp.ability_cast matches 1.. run scoreboard players operation #ray_ability_cast sgp.dummy = @s sgp.ability_cast
