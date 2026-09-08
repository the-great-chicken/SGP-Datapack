#> sgp.ci:illusions_movement/scenarios/pose_1

execute positioned 0 80 0 run function sgp.ci:illusions_movement/fixture
dummy IllOther spawn
tag IllOther add sgp.ci.illusion_actor
gamemode creative IllOther
execute positioned 0 80 0 run tp IllOther ~12.5 ~1 ~8.5 0 0
execute as IllOther at @s run function sgp.ci:illusions_movement/formation {group:other}
execute at @s run function sgp.kits:abilities/illusions/tick
execute positioned 0 80 0 run function sgp.ci:illusions_movement/expect_pose {group:first,pose:standing}
dummy @s sneak true
