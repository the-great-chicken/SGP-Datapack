#> sgp.kits:illusions/movement/player_isolation
# @dummy
# @environment sgp.ci:illusions_movement/player_isolation
#
# Updating one caster leaves the other caster's formation where it was.

gamemode spectator @s
tp @s 0 88 0
await entity @s[predicate=sgp.ci:illusions_movement/area_loaded]
execute positioned 0 80 0 run function sgp.ci:illusions_movement/fixture
dummy IllOther spawn
tag IllOther add sgp.ci.illusion_actor
gamemode creative IllOther
execute positioned 0 80 0 run tp IllOther ~24.5 ~1 ~8.5 0 0
execute as IllOther at @s run function sgp.ci:illusions_movement/formation {group:other}
execute positioned 0 80 0 run tp @s ~10.5 ~1 ~8.5 0 0
execute at @s run function sgp.kits:abilities/illusions/tick
execute positioned 0 80 0 run function sgp.ci:illusions_movement/expect {group:first,direction:left,x:"~8.5",y:"~1",z:"~10.5"}
execute positioned 0 80 0 run function sgp.ci:illusions_movement/expect {group:first,direction:right,x:"~8.5",y:"~1",z:"~6.5"}
execute positioned 0 80 0 run function sgp.ci:illusions_movement/expect {group:first,direction:opposite,x:"~6.5",y:"~1",z:"~8.5"}
execute positioned 0 80 0 run function sgp.ci:illusions_movement/expect {group:other,direction:left,x:"~24.5",y:"~1",z:"~8.5"}
execute positioned 0 80 0 run function sgp.ci:illusions_movement/expect {group:other,direction:right,x:"~24.5",y:"~1",z:"~8.5"}
execute positioned 0 80 0 run function sgp.ci:illusions_movement/expect {group:other,direction:opposite,x:"~24.5",y:"~1",z:"~8.5"}
execute positioned 0 80 0 run tp IllOther ~24.5 ~1 ~10.5 0 0
execute as IllOther at @s run function sgp.kits:abilities/illusions/tick
execute positioned 0 80 0 run function sgp.ci:illusions_movement/expect {group:other,direction:left,x:"~22.5",y:"~1",z:"~8.5"}
execute positioned 0 80 0 run function sgp.ci:illusions_movement/expect {group:other,direction:right,x:"~26.5",y:"~1",z:"~8.5"}
execute positioned 0 80 0 run function sgp.ci:illusions_movement/expect {group:other,direction:opposite,x:"~24.5",y:"~1",z:"~6.5"}
execute positioned 0 80 0 run function sgp.ci:illusions_movement/expect {group:first,direction:left,x:"~8.5",y:"~1",z:"~10.5"}
execute positioned 0 80 0 run function sgp.ci:illusions_movement/expect {group:first,direction:right,x:"~8.5",y:"~1",z:"~6.5"}
execute positioned 0 80 0 run function sgp.ci:illusions_movement/expect {group:first,direction:opposite,x:"~6.5",y:"~1",z:"~8.5"}
