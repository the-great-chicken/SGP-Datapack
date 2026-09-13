#> sgp.kits:kd_projectiles/calculated_zero_kills
# @dummy
# @environment sgp.ci:kd_projectiles/calculated_zero_kills
#
# A player with ten deaths and no kills receives the full buff in melee and arrows.

gamemode spectator @s
tp @s 8.0 168.0 8.0
await entity @s[predicate=sgp.ci:kd_projectiles/area_loaded]
function sgp.ci:kd_projectiles/fixture
await entity @e[tag=sgp.ci.kd_target,x=8,y=162,z=8,distance=..4,nbt=!{active_effects:[{id:"minecraft:glowing"}]},type=husk]
scoreboard players set @s sgp.kills 0
scoreboard players set @s sgp.morts 10
attribute @s minecraft:attack_damage base set 10
function sgp.misc:kd_buffs_and_debuffs/main
assert score @s sgp.kd matches 0
execute store result score #ci.kd.melee sgp.dummy run attribute @s minecraft:attack_damage get 1000
assert score #ci.kd.melee sgp.dummy matches 13999..14001
function sgp.ci:kd_projectiles/launch {weapon:bow}
await entity @e[tag=sgp.ci.kd_target,x=8,y=162,z=8,distance=..4,nbt=!{Health:40.0f},type=husk]
function sgp.ci:kd_projectiles/expect_damage {health:26000}
