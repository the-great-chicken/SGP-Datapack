#> sgp.ci:kit_cleanup/expect_step

# {range}: step height multiplied by 10000.
execute store result score #ci.cleanup.step sgp.dummy run attribute @s minecraft:step_height get 10000
$assert score #ci.cleanup.step sgp.dummy matches $(range)
