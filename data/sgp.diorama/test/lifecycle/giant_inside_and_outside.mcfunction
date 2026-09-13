#> sgp.diorama:lifecycle/giant_inside_and_outside
# @dummy
# @environment sgp.ci:diorama_lifecycle/giant_inside_and_outside

gamemode spectator @s
tp @s 8.0 88.0 8.0
function sgp.ci:origin_arena/ready
await entity @e[tag=sgp.ci.origin_ready,x=8,y=88,z=8,distance=..1,predicate=sgp.ci:diorama_lifecycle/area_loaded,type=marker]
kill @e[tag=sgp.ci.origin_ready,type=marker]
function sgp.ci:diorama_lifecycle/fixture
tp @s 6.0 81.0 9.0
function sgp.ci:diorama_lifecycle/giant_update
function sgp.ci:diorama_lifecycle/count {type:giant,count:1}
tp @s 9.0 81.0 9.0
function sgp.ci:diorama_lifecycle/giant_update
assert entity @s[tag=sgp.inside_current_model,tag=!sgp.around_current_model]
function sgp.ci:diorama_lifecycle/count {type:giant,count:0}
tp @s 20.0 81.0 9.0
function sgp.ci:diorama_lifecycle/giant_update
assert not entity @s[tag=sgp.around_current_model]
function sgp.ci:diorama_lifecycle/count {type:giant,count:0}
