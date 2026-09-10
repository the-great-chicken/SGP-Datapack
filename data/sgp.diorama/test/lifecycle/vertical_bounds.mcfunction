#> sgp.diorama:lifecycle/vertical_bounds
# @dummy
# @environment sgp.ci:diorama_lifecycle/vertical_bounds

gamemode spectator @s
tp @s 8.0 88.0 8.0
function sgp.ci:perfect_accuracy/ready
await entity @e[tag=sgp.ci.origin_ready,x=8,y=88,z=8,distance=..1,predicate=sgp.ci:diorama_lifecycle/area_loaded,type=marker]
kill @e[tag=sgp.ci.origin_ready,type=marker]
function sgp.ci:diorama_lifecycle/fixture
tag @s add sgp.in_game
tp @s 34.0 76.0 34.0
function sgp.ci:diorama_lifecycle/small_update
function sgp.ci:diorama_lifecycle/count {type:small,count:0}
tp @s 34.0 81.0 34.0
function sgp.ci:diorama_lifecycle/small_update
function sgp.ci:diorama_lifecycle/count {type:small,count:1}
tp @s 34.0 90.0 34.0
function sgp.ci:diorama_lifecycle/small_update
function sgp.ci:diorama_lifecycle/count {type:small,count:0}
