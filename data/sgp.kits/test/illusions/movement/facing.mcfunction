#> sgp.kits:illusions/movement/facing
# @dummy
# @environment sgp.ci:illusions_movement
#
# Each decoy preserves the caster's pitch and faces its own side of the formation.

await predicate sgp.ci:illusions_movement/area_loaded
execute positioned 0 80 0 run function sgp.ci:illusions_movement/fixture
execute positioned 0 80 0 run tp @s ~10.5 ~1 ~8.5 30 25
execute at @s run function sgp.kits:abilities/illusions/tick
execute positioned 0 80 0 run function sgp.ci:illusions_movement/expect_facing {direction:left,yaw:120,pitch:25}
execute positioned 0 80 0 run function sgp.ci:illusions_movement/expect_facing {direction:right,yaw:-60,pitch:25}
execute positioned 0 80 0 run function sgp.ci:illusions_movement/expect_facing {direction:opposite,yaw:-150,pitch:25}
execute positioned 0 80 0 run tp @s ~10.5 ~1 ~8.5 -30 -20
execute at @s run function sgp.kits:abilities/illusions/tick
execute positioned 0 80 0 run function sgp.ci:illusions_movement/expect_facing {direction:left,yaw:60,pitch:-20}
execute positioned 0 80 0 run function sgp.ci:illusions_movement/expect_facing {direction:right,yaw:-120,pitch:-20}
execute positioned 0 80 0 run function sgp.ci:illusions_movement/expect_facing {direction:opposite,yaw:150,pitch:-20}
