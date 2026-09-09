#> sgp.ci:kit_passives/expect_step

# {range}: effective step height multiplied by 10000.
execute store result score #ci.passive.step sgp.dummy run attribute @s minecraft:step_height get 10000
$assert score #ci.passive.step sgp.dummy matches $(range)
