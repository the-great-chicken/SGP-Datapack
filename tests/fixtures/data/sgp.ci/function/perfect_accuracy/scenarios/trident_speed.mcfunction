#> sgp.ci:perfect_accuracy/scenarios/trident_speed

function sgp.ci:perfect_accuracy/clear_projectiles

tp @s 8.0 88.0 8.0 0 0
execute at @s run function sgp.ci:perfect_accuracy/create {type:trident,motion:"[3.0,4.0,0.0]"}
assert entity @n[tag=sgp.ci.accuracy_new,x=8,y=88,z=8,distance=..3,type=trident]
execute as @n[tag=sgp.ci.accuracy_new,x=8,y=88,z=8,distance=..3,type=trident] run function sgp.kits:projectile/reset_velocity
assert entity @n[tag=sgp.ci.accuracy_new,x=8,y=88,z=8,distance=..3,type=trident]
execute as @n[tag=sgp.ci.accuracy_new,x=8,y=88,z=8,distance=..3,type=trident] run function sgp.ci:perfect_accuracy/check {x:"-20..20",y:"-20..20",z:"49980..50020"}
function sgp.ci:perfect_accuracy/clear_projectiles
