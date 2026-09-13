#> sgp.ci:pco_targeting/expect_damage
# `{damage: attack damage * 1000}`
#
# Read effective attack damage at fixed-point precision and compare it to the expected value.

execute store result score #ci.pco.attack sgp.dummy run attribute @s minecraft:attack_damage get 1000
$assert score #ci.pco.attack sgp.dummy matches $(damage)
