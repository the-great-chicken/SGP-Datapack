#> sgp.ci:illusions_movement/scenarios/pose_2

execute at @s run function sgp.kits:abilities/illusions/tick
execute positioned 0 80 0 run function sgp.ci:illusions_movement/expect_pose {group:first,pose:crouching}
execute as IllOther at @s run function sgp.kits:abilities/illusions/tick
execute positioned 0 80 0 run function sgp.ci:illusions_movement/expect_pose {group:other,pose:standing}
execute positioned 0 80 0 run function sgp.ci:illusions_movement/expect_pose {group:first,pose:crouching}
dummy @s sneak false
