#> sgp.ci:illusions_movement/scenarios/pose_3

execute at @s run function sgp.kits:abilities/illusions/tick
execute positioned 0 80 0 run function sgp.ci:illusions_movement/expect_pose {group:first,pose:standing}
