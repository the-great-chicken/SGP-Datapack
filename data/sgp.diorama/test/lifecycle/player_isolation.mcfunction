#> sgp.diorama:lifecycle/player_isolation
# @dummy
# @environment sgp.ci:diorama_lifecycle/player_isolation

gamemode spectator @s
tp @s 8.0 88.0 8.0
function sgp.ci:perfect_accuracy/ready
await entity @e[tag=sgp.ci.origin_ready,x=8,y=88,z=8,distance=..1,predicate=sgp.ci:diorama_lifecycle/area_loaded,type=marker]
kill @e[tag=sgp.ci.origin_ready,type=marker]
function sgp.ci:diorama_lifecycle/fixture
dummy DioramaPeer spawn
gamemode survival DioramaPeer
execute as DioramaPeer run function #bs.id:give_suid
tag DioramaPeer add sgp.in_game
tag @s add sgp.in_game
tp @s 34.0 81.0 34.0
tp DioramaPeer 36.0 81.0 36.0
function sgp.ci:diorama_lifecycle/small_update
function sgp.ci:diorama_lifecycle/count {type:small,count:1}
execute as DioramaPeer run function sgp.ci:diorama_lifecycle/count {type:small,count:1}
tp @s 42.0 81.0 34.0
function sgp.ci:diorama_lifecycle/small_update
function sgp.ci:diorama_lifecycle/count {type:small,count:0}
execute as DioramaPeer run function sgp.ci:diorama_lifecycle/count {type:small,count:1}
dummy DioramaPeer leave
