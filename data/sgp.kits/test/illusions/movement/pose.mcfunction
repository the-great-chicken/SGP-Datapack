#> sgp.kits:illusions/movement/pose
# @dummy
# @environment sgp.ci:illusions_movement/pose
#
# Crouching and standing apply on the current update, independently for each caster.

gamemode spectator @s
tp @s 0 88 0
await entity @s[predicate=sgp.ci:illusions_movement/area_loaded]
execute positioned 0 80 0 run function sgp.ci:illusions_movement/fixture
dummy IllOther spawn
tag IllOther add sgp.ci.illusion_actor
gamemode creative IllOther
execute positioned 0 80 0 run tp IllOther ~12.5 ~1 ~8.5 0 0
execute as IllOther at @s run function sgp.ci:illusions_movement/formation {group:other}
execute at @s run function sgp.kits:abilities/illusions/tick
execute positioned 0 80 0 run function sgp.ci:illusions_movement/expect_pose {group:first,pose:standing}
dummy @s sneak true
await predicate sgp.misc:is_sneaking
execute at @s run function sgp.kits:abilities/illusions/tick
execute positioned 0 80 0 run function sgp.ci:illusions_movement/expect_pose {group:first,pose:crouching}
execute as IllOther at @s run function sgp.kits:abilities/illusions/tick
execute positioned 0 80 0 run function sgp.ci:illusions_movement/expect_pose {group:other,pose:standing}
execute positioned 0 80 0 run function sgp.ci:illusions_movement/expect_pose {group:first,pose:crouching}
dummy @s sneak false
await not predicate sgp.misc:is_sneaking
execute at @s run function sgp.kits:abilities/illusions/tick
execute positioned 0 80 0 run function sgp.ci:illusions_movement/expect_pose {group:first,pose:standing}
