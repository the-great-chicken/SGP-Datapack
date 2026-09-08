#> sgp.kits:perfect_accuracy/shooter_isolation
# @dummy
# @environment sgp.ci:perfect_accuracy
#
# Correction uses the projectile's owner, regardless of the caller's position and rotation, and leaves other projectiles alone.

gamemode spectator @s
tp @s 8 88 8 0 0
await entity @s[predicate=sgp.ci:perfect_accuracy/area_loaded]
function sgp.ci:perfect_accuracy/clear_projectiles

dummy AimOther spawn
gamemode spectator AimOther
tp AimOther 10 88 8 90 0
execute at @s run function sgp.ci:perfect_accuracy/create {type:arrow,motion:"[0.0,0.0,2.0]"}
tag @e[tag=sgp.ci.accuracy_new,type=arrow] add sgp.ci.accuracy_control
tag @e[tag=sgp.ci.accuracy_new,type=arrow] remove sgp.ci.accuracy_new
execute as AimOther at @s run function sgp.ci:perfect_accuracy/create {type:arrow,motion:"[0.0,0.0,1.0]"}
assert entity @n[tag=sgp.ci.accuracy_new,x=10,y=88,z=8,distance=..3,type=arrow]
execute as @n[tag=sgp.ci.accuracy_new,x=10,y=88,z=8,distance=..3,type=arrow] positioned 8 88 8 rotated 0 0 run function sgp.kits:projectile/reset_velocity
assert entity @n[tag=sgp.ci.accuracy_new,x=10,y=88,z=8,distance=..3,type=arrow]
execute as @n[tag=sgp.ci.accuracy_new,x=10,y=88,z=8,distance=..3,type=arrow] run function sgp.ci:perfect_accuracy/check {x:"-10020..-9980",y:"-20..20",z:"-20..20"}
assert entity @n[tag=sgp.ci.accuracy_control,x=8,y=88,z=8,distance=..3,type=arrow]
execute as @n[tag=sgp.ci.accuracy_control,x=8,y=88,z=8,distance=..3,type=arrow] run function sgp.ci:perfect_accuracy/check {x:"0",y:"0",z:"20000"}
kill @e[tag=sgp.ci.accuracy,type=arrow]
dummy AimOther leave
