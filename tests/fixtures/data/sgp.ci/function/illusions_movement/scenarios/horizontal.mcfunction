#> sgp.ci:illusions_movement/scenarios/horizontal

execute positioned 0 80 0 run function sgp.ci:illusions_movement/fixture
execute positioned 0 80 0 run tp @s ~10.5 ~1 ~9.5 0 0
execute at @s run function sgp.kits:abilities/illusions/tick
execute positioned 0 80 0 run function sgp.ci:illusions_movement/expect {group:first,direction:left,x:"~7.5",y:"~1",z:"~10.5"}
execute positioned 0 80 0 run function sgp.ci:illusions_movement/expect {group:first,direction:right,x:"~9.5",y:"~1",z:"~6.5"}
execute positioned 0 80 0 run function sgp.ci:illusions_movement/expect {group:first,direction:opposite,x:"~6.5",y:"~1",z:"~7.5"}
# Returning to the center must not accumulate previous offsets.
execute positioned 0 80 0 run tp @s ~8.5 ~1 ~8.5 0 0
execute at @s run function sgp.kits:abilities/illusions/tick
execute positioned 0 80 0 run function sgp.ci:illusions_movement/expect {group:first,direction:left,x:"~8.5",y:"~1",z:"~8.5"}
execute positioned 0 80 0 run function sgp.ci:illusions_movement/expect {group:first,direction:right,x:"~8.5",y:"~1",z:"~8.5"}
execute positioned 0 80 0 run function sgp.ci:illusions_movement/expect {group:first,direction:opposite,x:"~8.5",y:"~1",z:"~8.5"}
