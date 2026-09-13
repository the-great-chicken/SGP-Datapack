#> sgp.kits:kd_projectiles/buff
# @dummy
# @environment sgp.ci:kd_projectiles/buff
#
# An eligible low-K/D shooter deals increased arrow damage.

gamemode spectator @s
tp @s 8.0 168.0 8.0
await entity @s[predicate=sgp.ci:kd_projectiles/area_loaded]
function sgp.ci:kd_projectiles/fixture
await entity @e[tag=sgp.ci.kd_target,x=8,y=162,z=8,distance=..4,nbt=!{active_effects:[{id:"minecraft:glowing"}]},type=husk]
function sgp.ci:kd_projectiles/fire {kd:30,kills:10,deaths:10}
await entity @e[tag=sgp.ci.kd_target,x=8,y=162,z=8,distance=..4,nbt=!{Health:40.0f},type=husk]
function sgp.ci:kd_projectiles/expect_damage {health:26000}
