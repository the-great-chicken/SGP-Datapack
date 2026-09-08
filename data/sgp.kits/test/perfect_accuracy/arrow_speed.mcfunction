#> sgp.kits:perfect_accuracy/arrow_speed
# @dummy
# @environment sgp.ci:perfect_accuracy
#
# Correct spread without replacing the bow's launch speed; a stationary arrow stays stationary.

gamemode spectator @s
tp @s 8 88 8 0 0
await entity @s[predicate=sgp.ci:perfect_accuracy/area_loaded]
function sgp.ci:perfect_accuracy/clear_projectiles

execute at @s run function sgp.ci:perfect_accuracy/create {type:arrow,motion:"[3.0,4.0,0.0]"}
assert entity @n[tag=sgp.ci.accuracy_new,x=8,y=88,z=8,distance=..3,type=arrow]
execute as @n[tag=sgp.ci.accuracy_new,x=8,y=88,z=8,distance=..3,type=arrow] run function sgp.kits:projectile/reset_velocity
assert entity @n[tag=sgp.ci.accuracy_new,x=8,y=88,z=8,distance=..3,type=arrow]
execute as @n[tag=sgp.ci.accuracy_new,x=8,y=88,z=8,distance=..3,type=arrow] run function sgp.ci:perfect_accuracy/check {x:"-20..20",y:"-20..20",z:"49980..50020"}
kill @e[tag=sgp.ci.accuracy_new,type=arrow]
execute at @s run function sgp.ci:perfect_accuracy/create {type:arrow,motion:"[0.0,0.0,0.0]"}
assert entity @n[tag=sgp.ci.accuracy_new,x=8,y=88,z=8,distance=..3,type=arrow]
execute as @n[tag=sgp.ci.accuracy_new,x=8,y=88,z=8,distance=..3,type=arrow] run function sgp.kits:projectile/reset_velocity
assert entity @n[tag=sgp.ci.accuracy_new,x=8,y=88,z=8,distance=..3,type=arrow]
execute as @n[tag=sgp.ci.accuracy_new,x=8,y=88,z=8,distance=..3,type=arrow] run function sgp.ci:perfect_accuracy/check {x:"0",y:"0",z:"0"}
kill @e[tag=sgp.ci.accuracy_new,type=arrow]
