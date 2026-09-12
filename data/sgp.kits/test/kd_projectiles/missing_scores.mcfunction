#> sgp.kits:kd_projectiles/missing_scores
# @dummy
# @environment sgp.ci:kd_projectiles/missing_scores
#
# A shooter without K/D or eligibility scores deals ordinary arrow damage.

gamemode spectator @s
tp @s 8.0 168.0 8.0
await entity @s[predicate=sgp.ci:kd_projectiles/area_loaded]
function sgp.ci:kd_projectiles/fixture
await entity @e[tag=sgp.ci.kd_target,x=8,y=162,z=8,distance=..4,nbt=!{active_effects:[{id:"minecraft:glowing"}]},type=husk]
scoreboard players reset @s sgp.kd
scoreboard players reset @s sgp.kills
scoreboard players reset @s sgp.morts
function sgp.ci:kd_projectiles/launch {weapon:bow}
await entity @e[tag=sgp.ci.kd_target,x=8,y=162,z=8,distance=..4,nbt=!{Health:40.0f},type=husk]
function sgp.ci:kd_projectiles/expect_damage {health:30000}
