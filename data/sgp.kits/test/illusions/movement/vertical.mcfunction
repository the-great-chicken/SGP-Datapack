#> sgp.kits:illusions/movement/vertical
# @dummy
# @environment sgp.ci:illusions_movement/vertical
#
# Decoys follow a jump's height while retaining their horizontal formation.

gamemode spectator @s
tp @s 0 88 0
await entity @s[predicate=sgp.ci:illusions_movement/area_loaded]
function sgp.ci:origin_arena/ready
await entity @e[tag=sgp.ci.origin_ready,x=8,y=88,z=8,distance=..1,type=marker]
kill @e[tag=sgp.ci.origin_ready,type=marker]
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
