#> sgp.ci:kd_buffs_and_debuffs/check
# `{kills, deaths: nonnegative int, kd: K/D * 100, damage: attack damage * 100}`
#
# Check the production calculation and total melee attack damage, scaled by 100.

$scoreboard players set @s sgp.kills $(kills)
$scoreboard players set @s sgp.morts $(deaths)
function sgp.misc:kd_buffs_and_debuffs/main
$assert score @s sgp.kd matches $(kd)
execute store result score @s sgp.dummy run attribute @s minecraft:attack_damage get 100
$assert score @s sgp.dummy matches $(damage)
