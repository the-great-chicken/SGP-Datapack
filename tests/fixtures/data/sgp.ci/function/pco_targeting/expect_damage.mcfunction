#> sgp.ci:pco_targeting/expect_damage
# {damage}: check effective melee damage rather than effect bookkeeping.

execute store result score #ci.pco.attack sgp.dummy run attribute @s minecraft:attack_damage get 1000
$assert score #ci.pco.attack sgp.dummy matches $(damage)
