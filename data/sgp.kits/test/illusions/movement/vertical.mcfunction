#> sgp.kits:illusions/movement/vertical
# @dummy
# @environment sgp.ci:illusions_movement
#
# Decoys follow a jump's height while retaining their horizontal formation.

await predicate sgp.ci:illusions_movement/area_loaded
execute positioned 0 80 0 run function sgp.ci:illusions_movement/fixture
execute positioned 0 80 0 run tp @s ~10.5 ~3.5 ~8.5 0 0
execute at @s run function sgp.kits:abilities/illusions/tick
execute positioned 0 80 0 run function sgp.ci:illusions_movement/expect {group:first,direction:left,x:"~8.5",y:"~3.5",z:"~10.5"}
execute positioned 0 80 0 run function sgp.ci:illusions_movement/expect {group:first,direction:right,x:"~8.5",y:"~3.5",z:"~6.5"}
execute positioned 0 80 0 run function sgp.ci:illusions_movement/expect {group:first,direction:opposite,x:"~6.5",y:"~3.5",z:"~8.5"}
execute positioned 0 80 0 run tp @s ~10.5 ~1 ~8.5 0 0
execute at @s run function sgp.kits:abilities/illusions/tick
execute positioned 0 80 0 run function sgp.ci:illusions_movement/expect {group:first,direction:left,x:"~8.5",y:"~1",z:"~10.5"}
execute positioned 0 80 0 run function sgp.ci:illusions_movement/expect {group:first,direction:right,x:"~8.5",y:"~1",z:"~6.5"}
execute positioned 0 80 0 run function sgp.ci:illusions_movement/expect {group:first,direction:opposite,x:"~6.5",y:"~1",z:"~8.5"}
