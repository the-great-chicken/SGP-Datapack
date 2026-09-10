#> sgp.kits:kd_projectiles/crossbow_scaling
# @dummy
# @environment sgp.ci:kd_projectiles/crossbow_scaling
#
# A crossbow-fired arrow receives the same K/D scaling as a bow-fired arrow.

gamemode spectator @s
tp @s 8.0 168.0 8.0
await entity @s[predicate=sgp.ci:kd_projectiles/area_loaded]
function sgp.ci:kd_projectiles/fixture
await entity @e[tag=sgp.ci.kd_target,x=8,y=162,z=8,distance=..4,nbt=!{active_effects:[{id:"minecraft:glowing"}]},type=husk]
scoreboard players set @s sgp.kills 40
scoreboard players set @s sgp.morts 10
function sgp.misc:kd_buffs_and_debuffs/main
function sgp.ci:kd_projectiles/launch {weapon:crossbow}
await entity @e[tag=sgp.ci.kd_target,x=8,y=162,z=8,distance=..4,nbt=!{Health:40.0f},type=husk]
function sgp.ci:kd_projectiles/expect_damage {health:35000}
