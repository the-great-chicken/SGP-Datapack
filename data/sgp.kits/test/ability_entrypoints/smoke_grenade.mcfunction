#> sgp.kits:ability_entrypoints/smoke_grenade
# @dummy
# @environment sgp.ci:ability_entrypoints/smoke_grenade
#
# Eclaireur routing must launch one owned grenade with its visual passenger and direction-derived velocity.

function sgp.ci:ability_entrypoints/seed_stats {id:920005,kit:7,ability:"smoke_grenade"}
tag @s add sgp.eclaireur
tp @s ~ ~ ~ 0 0

execute at @s run function sgp.kits:abilities/route_ability

# Claim both halves of the projectile immediately after production initialization.
tag @e[tag=sgp.smoke_grenade,distance=..4,type=snowball] add sgp.ci.ability_entrypoint
tag @e[tag=sgp.smoke_visual,distance=..4,type=item_display] add sgp.ci.ability_entrypoint
function sgp.ci:ability_entrypoints/expect_cooldown {ability:"smoke_grenade"}
execute store result score #ci.ability.snowballs sgp.dummy if entity @e[tag=sgp.ci.ability_entrypoint,tag=sgp.smoke_grenade,distance=..4,type=snowball]
execute store result score #ci.ability.visuals sgp.dummy if entity @e[tag=sgp.ci.ability_entrypoint,tag=sgp.smoke_visual,distance=..4,type=item_display]
assert score #ci.ability.snowballs sgp.dummy matches 1
assert score #ci.ability.visuals sgp.dummy matches 1
assert score @e[tag=sgp.ci.ability_entrypoint,tag=sgp.smoke_visual,limit=1,type=item_display] sgp.id matches 920005
execute as @e[tag=sgp.ci.ability_entrypoint,tag=sgp.smoke_visual,limit=1,type=item_display] on vehicle run tag @s add sgp.ci.ability_entrypoint_vehicle
assert entity @e[tag=sgp.ci.ability_entrypoint_vehicle,tag=sgp.smoke_grenade,type=snowball]
execute store result score #ci.ability.motion_z sgp.dummy run data get entity @e[tag=sgp.ci.ability_entrypoint,tag=sgp.smoke_grenade,limit=1,type=snowball] Motion[2] 1000
assert score #ci.ability.motion_z sgp.dummy matches 1499..1501
