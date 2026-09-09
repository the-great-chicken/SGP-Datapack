#> sgp.ci:death_cleanup/scenarios/assassinate

function sgp.ci:death_cleanup/fixture
tag @s add sgp.enderman
tag @s add sgp.assassin
scoreboard players set @s sgp.kit_id 9
attribute @s minecraft:knockback_resistance base set 0
attribute @s minecraft:knockback_resistance modifier add sgp:assassinate 1 add_value
attribute @s minecraft:knockback_resistance modifier add sgp.ci:other_resistance 0.2 add_value
effect give @s resistance 60 4 true
function sgp.kits:cleanup_after_death
function sgp.ci:death_cleanup/expect_cleared
assert not entity @s[tag=sgp.assassin]
assert not entity @s[tag=sgp.enderman]
execute store result score #ci.death.resistance sgp.dummy run attribute @s minecraft:knockback_resistance get 10000
assert score #ci.death.resistance sgp.dummy matches 1999..2001
