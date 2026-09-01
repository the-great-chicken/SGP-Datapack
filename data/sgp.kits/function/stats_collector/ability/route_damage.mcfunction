#> sgp.kits:stats_collector/ability/route_damage
#
# Executed as the damage source player for an event already proven to have dealt
# positive health damage. #ability_damage_cause contains the final mechanism.

execute unless entity @a[tag=sgp.ability_damage_target,tag=sgp.in_game,tag=!sgp.peaceful,limit=1] run return 0
execute if score @a[tag=sgp.ability_damage_target,limit=1] sgp.id = @s sgp.id run return 0

execute if score @s sgp.ability_kind matches 1 if score #ability_damage_cause sgp.dummy matches 100 run return run function sgp.kits:stats_collector/ability/mark_affected {kit_id:1,ability_path:"cleave"}

execute if score @s sgp.ability_kind matches 3 if score @s sgp.ability_result_window matches 1.. if score #ability_damage_cause sgp.dummy matches 15 run return run function sgp.kits:stats_collector/ability/mark_affected {kit_id:3,ability_path:"fangs"}

execute if score @s sgp.ability_kind matches 4 if score @s sgp.ability_result_window matches 1.. if score #ability_damage_cause sgp.dummy matches 11 run return run function sgp.kits:stats_collector/ability/mark_affected {kit_id:4,ability_path:"tnt"}
execute if score @s sgp.ability_kind matches 4 if score @s sgp.ability_result_window matches 1.. if score #ability_damage_cause sgp.dummy matches 14 run return run function sgp.kits:stats_collector/ability/mark_affected {kit_id:4,ability_path:"tnt"}

execute if score @s sgp.ability_kind matches 5 if entity @s[tag=sgp.stats_tank_boost_active] if score #ability_damage_cause sgp.dummy matches 1 run return run function sgp.kits:stats_collector/ability/tank_hit

execute if score @s sgp.ability_kind matches 6 if score #ability_damage_cause sgp.dummy matches 102 run return run function sgp.kits:stats_collector/ability/mark_affected {kit_id:6,ability_path:"rays"}
