#> sgp.ci:kd_projectiles/scenarios/calculated_zero_kills

scoreboard players set @s sgp.kills 0
scoreboard players set @s sgp.morts 10
attribute @s minecraft:attack_damage base set 10
function sgp.misc:kd_buffs_and_debuffs/main
assert score @s sgp.kd matches 0
execute store result score #ci.kd.melee sgp.dummy run attribute @s minecraft:attack_damage get 1000
assert score #ci.kd.melee sgp.dummy matches 13999..14001
function sgp.ci:kd_projectiles/launch {weapon:bow}
