#> sgp.diorama:lifecycle/eligibility
# @dummy
# @environment sgp.ci:diorama_lifecycle/eligibility

gamemode spectator @s
tp @s 8.0 88.0 8.0
function sgp.ci:perfect_accuracy/ready
await entity @e[tag=sgp.ci.origin_ready,x=8,y=88,z=8,distance=..1,predicate=sgp.ci:diorama_lifecycle/area_loaded,type=marker]
kill @e[tag=sgp.ci.origin_ready,type=marker]
function sgp.ci:diorama_lifecycle/fixture
tp @s 34.0 81.0 34.0
function sgp.ci:diorama_lifecycle/small_update
assert not entity @s[tag=sgp.has_small_mannequin_96001]
function sgp.ci:diorama_lifecycle/count {type:small,count:0}
tag @s add sgp.in_game
tp @s 42.0 81.0 34.0
function sgp.ci:diorama_lifecycle/small_update
function sgp.ci:diorama_lifecycle/count {type:small,count:0}
