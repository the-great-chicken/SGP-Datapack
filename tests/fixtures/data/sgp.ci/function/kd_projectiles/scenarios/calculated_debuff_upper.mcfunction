#> sgp.ci:kd_projectiles/scenarios/calculated_debuff_upper

scoreboard players set @s sgp.kills 249
scoreboard players set @s sgp.morts 100
attribute @s minecraft:attack_damage base set 10
function sgp.misc:kd_buffs_and_debuffs/main
assert score @s sgp.kd matches 249
execute store result score #ci.kd.melee sgp.dummy run attribute @s minecraft:attack_damage get 1000
assert score #ci.kd.melee sgp.dummy matches 8999..9001
function sgp.ci:kd_projectiles/launch {weapon:bow}
