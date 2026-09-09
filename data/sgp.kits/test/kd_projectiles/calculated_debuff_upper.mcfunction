#> sgp.kits:kd_projectiles/calculated_debuff_upper
# @dummy
# @environment sgp.ci:kd_projectiles/calculated_debuff_upper
#
# K/D 2.49 remains in the first debuff tier for both melee and arrows.

gamemode spectator @s
tp @s 8.0 168.0 8.0
await entity @s[predicate=sgp.ci:kd_projectiles/area_loaded]
function sgp.ci:kd_projectiles/fixture
await entity @e[tag=sgp.ci.kd_target,x=8,y=162,z=8,distance=..4,nbt=!{active_effects:[{id:"minecraft:glowing"}]},type=husk]
function sgp.ci:kd_projectiles/scenarios/calculated_debuff_upper
await entity @e[tag=sgp.ci.kd_target,x=8,y=162,z=8,distance=..4,nbt=!{Health:40.0f},type=husk]
function sgp.ci:kd_projectiles/expect_damage {health:31000}
