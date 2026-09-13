#> sgp.kits:kd_projectiles/calculated_buff_upper
# @dummy
# @environment sgp.ci:kd_projectiles/calculated_buff_upper
#
# The buff includes calculated K/D 0.80 for both melee and arrows.

gamemode spectator @s
tp @s 8.0 168.0 8.0
await entity @s[predicate=sgp.ci:kd_projectiles/area_loaded]
function sgp.ci:kd_projectiles/fixture
await entity @e[tag=sgp.ci.kd_target,x=8,y=162,z=8,distance=..4,nbt=!{active_effects:[{id:"minecraft:glowing"}]},type=husk]
scoreboard players set @s sgp.kills 80
scoreboard players set @s sgp.morts 100
attribute @s minecraft:attack_damage base set 10
function sgp.misc:kd_buffs_and_debuffs/main
assert score @s sgp.kd matches 80
execute store result score #ci.kd.melee sgp.dummy run attribute @s minecraft:attack_damage get 1000
assert score #ci.kd.melee sgp.dummy matches 10999..11001
function sgp.ci:kd_projectiles/launch {weapon:bow}
await entity @e[tag=sgp.ci.kd_target,x=8,y=162,z=8,distance=..4,nbt=!{Health:40.0f},type=husk]
function sgp.ci:kd_projectiles/expect_damage {health:29000}
