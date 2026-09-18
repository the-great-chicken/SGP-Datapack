#> sgp.diorama:lifecycle/overlapping_owners
# @dummy
# @environment sgp.ci:diorama_lifecycle/overlapping_owners

gamemode spectator @s
tp @s 8.0 88.0 8.0
function sgp.ci:origin_arena/ready
await entity @e[tag=sgp.ci.origin_ready,x=8,y=88,z=8,distance=..1,predicate=sgp.ci:diorama_lifecycle/area_loaded,type=marker]
kill @e[tag=sgp.ci.origin_ready,type=marker]
function sgp.ci:diorama_lifecycle/fixture
dummy DioramaOverlap spawn
gamemode survival DioramaOverlap
execute as DioramaOverlap run function #bs.id:give_suid
tag DioramaOverlap add sgp.in_game
tag @s add sgp.in_game

# Both owners occupy exactly the same point when their small mannequins are linked.
tp @s 34.0 81.0 34.0
tp DioramaOverlap 34.0 81.0 34.0
function sgp.ci:diorama_lifecycle/small_update
function sgp.ci:diorama_lifecycle/count {type:small,count:1}
execute as DioramaOverlap run function sgp.ci:diorama_lifecycle/count {type:small,count:1}
function sgp.ci:diorama_lifecycle/small_update
function sgp.ci:diorama_lifecycle/count {type:small,count:1}
execute as DioramaOverlap run function sgp.ci:diorama_lifecycle/count {type:small,count:1}

# Repeat in the outer shell, then remove only one owner's giant.
tp @s 7.0 81.0 9.0
tp DioramaOverlap 7.0 81.0 9.0
function sgp.ci:diorama_lifecycle/small_update
function sgp.ci:diorama_lifecycle/giant_update
function sgp.ci:diorama_lifecycle/count {type:giant,count:1}
execute as DioramaOverlap run function sgp.ci:diorama_lifecycle/count {type:giant,count:1}
tp @s 60.0 81.0 60.0
function sgp.ci:diorama_lifecycle/giant_update
function sgp.ci:diorama_lifecycle/count {type:giant,count:0}
execute as DioramaOverlap run function sgp.ci:diorama_lifecycle/count {type:giant,count:1}
dummy DioramaOverlap leave
