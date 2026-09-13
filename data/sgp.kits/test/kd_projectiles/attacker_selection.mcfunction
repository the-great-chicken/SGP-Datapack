#> sgp.kits:kd_projectiles/attacker_selection
# @dummy
# @environment sgp.ci:kd_projectiles/attacker_selection
#
# Damage uses the shooter's K/D rather than the target's opposing buff.

gamemode spectator @s
tp @s 8.0 168.0 8.0
await entity @s[predicate=sgp.ci:kd_projectiles/area_loaded]
function sgp.ci:kd_projectiles/fixture
await entity @e[tag=sgp.ci.kd_target,x=8,y=162,z=8,distance=..4,nbt=!{active_effects:[{id:"minecraft:glowing"}]},type=husk]
scoreboard players set @e[tag=sgp.ci.kd_target,x=8,y=162,z=8,distance=..4,type=husk] sgp.kd 30
scoreboard players set @e[tag=sgp.ci.kd_target,x=8,y=162,z=8,distance=..4,type=husk] sgp.kills 10
scoreboard players set @e[tag=sgp.ci.kd_target,x=8,y=162,z=8,distance=..4,type=husk] sgp.morts 10
function sgp.ci:kd_projectiles/fire {kd:400,kills:10,deaths:10}
await entity @e[tag=sgp.ci.kd_target,x=8,y=162,z=8,distance=..4,nbt=!{Health:40.0f},type=husk]
function sgp.ci:kd_projectiles/expect_damage {health:35000}
