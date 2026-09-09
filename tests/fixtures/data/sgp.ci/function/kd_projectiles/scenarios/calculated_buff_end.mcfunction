#> sgp.ci:kd_projectiles/scenarios/calculated_buff_end

scoreboard players set @s sgp.kills 81
scoreboard players set @s sgp.morts 100
attribute @s minecraft:attack_damage base set 10
function sgp.misc:kd_buffs_and_debuffs/main
assert score @s sgp.kd matches 81
execute store result score #ci.kd.melee sgp.dummy run attribute @s minecraft:attack_damage get 1000
assert score #ci.kd.melee sgp.dummy matches 9999..10001
function sgp.ci:kd_projectiles/launch {weapon:bow}
