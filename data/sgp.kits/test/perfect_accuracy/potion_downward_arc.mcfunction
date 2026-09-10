#> sgp.kits:perfect_accuracy/potion_downward_arc
# @dummy
# @environment sgp.ci:perfect_accuracy/potion_downward_arc
#
# A downward-thrown potion remains downward despite the intended upward adjustment.

gamemode spectator @s
tp @s 8.0 88.0 8.0 0 0
await entity @s[predicate=sgp.ci:perfect_accuracy/area_loaded]
function sgp.ci:perfect_accuracy/ready
await entity @e[tag=sgp.ci.origin_ready,x=8,y=88,z=8,distance=..1,type=marker]
kill @e[tag=sgp.ci.origin_ready,type=marker]
function sgp.ci:perfect_accuracy/clear_projectiles

tp @s 8.0 88.0 8.0 0 90
execute at @s run function sgp.ci:perfect_accuracy/create {type:splash_potion,motion:"[0.0,0.0,3.0]"}
assert entity @n[tag=sgp.ci.accuracy_new,x=8,y=88,z=8,distance=..3,type=splash_potion]
execute as @n[tag=sgp.ci.accuracy_new,x=8,y=88,z=8,distance=..3,type=splash_potion] run function sgp.kits:projectile/reset_velocity
assert entity @n[tag=sgp.ci.accuracy_new,x=8,y=88,z=8,distance=..3,type=splash_potion]
execute as @n[tag=sgp.ci.accuracy_new,x=8,y=88,z=8,distance=..3,type=splash_potion] run function sgp.ci:perfect_accuracy/check {x:"-20..20",y:"-3520..-3480",z:"-20..20"}
function sgp.ci:perfect_accuracy/clear_projectiles
