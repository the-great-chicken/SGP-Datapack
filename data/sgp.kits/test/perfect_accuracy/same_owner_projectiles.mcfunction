#> sgp.kits:perfect_accuracy/same_owner_projectiles
# @dummy
# @environment sgp.ci:perfect_accuracy/same_owner_projectiles
#
# Correcting one projectile leaves another projectile from the same owner unchanged.

gamemode spectator @s
tp @s 8.0 88.0 8.0 0 0
await entity @s[predicate=sgp.ci:perfect_accuracy/area_loaded]
function sgp.ci:perfect_accuracy/ready
await entity @e[tag=sgp.ci.origin_ready,x=8,y=88,z=8,distance=..1,type=marker]
kill @e[tag=sgp.ci.origin_ready,type=marker]
function sgp.ci:perfect_accuracy/clear_projectiles

tp @s 8.0 88.0 8.0 0 0
execute at @s run function sgp.ci:perfect_accuracy/create {type:arrow,motion:"[1.0,2.0,2.0]"}
tag @e[tag=sgp.ci.accuracy_new,type=arrow] add sgp.ci.accuracy_control
tag @e[tag=sgp.ci.accuracy_new,type=arrow] remove sgp.ci.accuracy_new
execute at @s run function sgp.ci:perfect_accuracy/create {type:arrow,motion:"[3.0,4.0,0.0]"}
assert entity @n[tag=sgp.ci.accuracy_new,x=8,y=88,z=8,distance=..3,type=arrow]
execute as @n[tag=sgp.ci.accuracy_new,x=8,y=88,z=8,distance=..3,type=arrow] run function sgp.kits:projectile/reset_velocity
assert entity @n[tag=sgp.ci.accuracy_new,x=8,y=88,z=8,distance=..3,type=arrow]
execute as @n[tag=sgp.ci.accuracy_new,x=8,y=88,z=8,distance=..3,type=arrow] run function sgp.ci:perfect_accuracy/check {x:"-20..20",y:"-20..20",z:"49980..50020"}
execute as @n[tag=sgp.ci.accuracy_control,x=8,y=88,z=8,distance=..3,type=arrow] run function sgp.ci:perfect_accuracy/check {x:"10000",y:"20000",z:"20000"}
function sgp.ci:perfect_accuracy/clear_projectiles
