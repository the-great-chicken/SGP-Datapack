#> sgp.ci:kit_cleanup/scenarios/unrelated_attributes

function sgp.ci:kit_cleanup/loadout
attribute @s minecraft:step_height base set 0.8
attribute @s minecraft:step_height modifier add sgp.ci:other_step 0.2 add_value
attribute @s minecraft:movement_speed base set 0.1
attribute @s minecraft:movement_speed modifier add sgp.ci:other_speed 0.03 add_value
function sgp.ci:kit_cleanup/expect_step {range:"13999..14001"}
function sgp.kits:clear
function sgp.ci:kit_cleanup/expect_empty
function sgp.ci:kit_cleanup/expect_step {range:"9999..10001"}
execute store result score #ci.cleanup.speed sgp.dummy run attribute @s minecraft:movement_speed get 10000
assert score #ci.cleanup.speed sgp.dummy matches 1299..1301
