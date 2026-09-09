#> sgp.ci:kit_passives/expect_speed

# {range}: effective speed multiplied by 10000.
execute store result score #ci.passive.speed sgp.dummy run attribute @s minecraft:movement_speed get 10000
$assert score #ci.passive.speed sgp.dummy matches $(range)
