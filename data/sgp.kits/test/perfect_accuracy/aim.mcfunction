#> sgp.kits:perfect_accuracy/aim
# @dummy
# @environment sgp.ci:perfect_accuracy
#
# Horizontal and vertical aim both determine the corrected trajectory.

gamemode spectator @s
tp @s 8 88 8 0 0
await entity @s[predicate=sgp.ci:perfect_accuracy/area_loaded]
function sgp.ci:perfect_accuracy/clear_projectiles

tp @s 8 88 8 90 0
execute at @s run function sgp.ci:perfect_accuracy/create {type:arrow,motion:"[0.0,0.0,2.0]"}
assert entity @n[tag=sgp.ci.accuracy_new,x=8,y=88,z=8,distance=..3,type=arrow]
execute as @n[tag=sgp.ci.accuracy_new,x=8,y=88,z=8,distance=..3,type=arrow] run function sgp.kits:projectile/reset_velocity
assert entity @n[tag=sgp.ci.accuracy_new,x=8,y=88,z=8,distance=..3,type=arrow]
execute as @n[tag=sgp.ci.accuracy_new,x=8,y=88,z=8,distance=..3,type=arrow] run function sgp.ci:perfect_accuracy/check {x:"-20020..-19980",y:"-20..20",z:"-20..20"}
tp @s 8 88 8 0 -90
assert entity @n[tag=sgp.ci.accuracy_new,x=8,y=88,z=8,distance=..3,type=arrow]
execute as @n[tag=sgp.ci.accuracy_new,x=8,y=88,z=8,distance=..3,type=arrow] run function sgp.kits:projectile/reset_velocity
assert entity @n[tag=sgp.ci.accuracy_new,x=8,y=88,z=8,distance=..3,type=arrow]
execute as @n[tag=sgp.ci.accuracy_new,x=8,y=88,z=8,distance=..3,type=arrow] run function sgp.ci:perfect_accuracy/check {x:"-40..40",y:"19960..20040",z:"-40..40"}
kill @e[tag=sgp.ci.accuracy_new,type=arrow]
