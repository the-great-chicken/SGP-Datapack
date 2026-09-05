#> sgp.misc:kd_buffs_and_debuffs/missing_scores
# @dummy
#
# Missing kill/death scores behave like zero and do not retain an old ratio or modifier.

attribute @s minecraft:attack_damage base set 10
function sgp.ci:kd_buffs_and_debuffs/check {kills:250,deaths:100,kd:250,damage:800}
scoreboard players reset @s sgp.kills
scoreboard players reset @s sgp.morts
function sgp.misc:kd_buffs_and_debuffs/main
assert score @s sgp.kd matches 0
execute store result score @s sgp.dummy run attribute @s minecraft:attack_damage get 100
assert score @s sgp.dummy matches 1000

scoreboard players set @s sgp.kills 10
function sgp.misc:kd_buffs_and_debuffs/main
assert score @s sgp.kd matches 1000
execute store result score @s sgp.dummy run attribute @s minecraft:attack_damage get 100
assert score @s sgp.dummy matches 500

scoreboard players reset @s sgp.kills
scoreboard players set @s sgp.morts 10
function sgp.misc:kd_buffs_and_debuffs/main
assert score @s sgp.kd matches 0
execute store result score @s sgp.dummy run attribute @s minecraft:attack_damage get 100
assert score @s sgp.dummy matches 1400
