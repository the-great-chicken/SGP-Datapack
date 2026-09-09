#> sgp.ci:perfect_accuracy/scenarios/downward_aim

function sgp.ci:perfect_accuracy/clear_projectiles

tp @s 8.0 88.0 8.0 0 90
execute at @s run function sgp.ci:perfect_accuracy/create {type:arrow,motion:"[0.0,0.0,2.0]"}
assert entity @n[tag=sgp.ci.accuracy_new,x=8,y=88,z=8,distance=..3,type=arrow]
execute as @n[tag=sgp.ci.accuracy_new,x=8,y=88,z=8,distance=..3,type=arrow] run function sgp.kits:projectile/reset_velocity
assert entity @n[tag=sgp.ci.accuracy_new,x=8,y=88,z=8,distance=..3,type=arrow]
execute as @n[tag=sgp.ci.accuracy_new,x=8,y=88,z=8,distance=..3,type=arrow] run function sgp.ci:perfect_accuracy/check {x:"-40..40",y:"-20040..-19960",z:"-40..40"}
function sgp.ci:perfect_accuracy/clear_projectiles
