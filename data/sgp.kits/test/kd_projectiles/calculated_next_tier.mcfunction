#> sgp.kits:kd_projectiles/calculated_next_tier
# @dummy
# @environment sgp.ci:kd_projectiles/calculated_next_tier
#
# K/D 2.50 moves to the next debuff tier without overlapping the previous tier.

gamemode spectator @s
tp @s 8.0 168.0 8.0
await entity @s[predicate=sgp.ci:kd_projectiles/area_loaded]
function sgp.ci:kd_projectiles/fixture
await entity @e[tag=sgp.ci.kd_target,x=8,y=162,z=8,distance=..4,nbt=!{active_effects:[{id:"minecraft:glowing"}]},type=husk]
function sgp.ci:kd_projectiles/scenarios/calculated_next_tier
await entity @e[tag=sgp.ci.kd_target,x=8,y=162,z=8,distance=..4,nbt=!{Health:40.0f},type=husk]
function sgp.ci:kd_projectiles/expect_damage {health:32000}
