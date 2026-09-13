#> sgp.kits:perfect_accuracy/diagonal_aim
# @dummy
# @environment sgp.ci:perfect_accuracy/diagonal_aim
#
# Combined yaw and pitch correction preserves launch speed while aiming diagonally upwards.

gamemode spectator @s
tp @s 8.0 88.0 8.0 0 0
await entity @s[predicate=sgp.ci:perfect_accuracy/area_loaded]
function sgp.ci:origin_arena/ready
await entity @e[tag=sgp.ci.origin_ready,x=8,y=88,z=8,distance=..1,type=marker]
kill @e[tag=sgp.ci.origin_ready,type=marker]
function sgp.ci:perfect_accuracy/clear_projectiles

tp @s 8.0 88.0 8.0 45 -30
execute at @s run function sgp.ci:perfect_accuracy/create {type:arrow,motion:"[0.0,0.0,2.0]"}
assert entity @n[tag=sgp.ci.accuracy_new,x=8,y=88,z=8,distance=..3,type=arrow]
execute as @n[tag=sgp.ci.accuracy_new,x=8,y=88,z=8,distance=..3,type=arrow] run function sgp.kits:projectile/reset_velocity
assert entity @n[tag=sgp.ci.accuracy_new,x=8,y=88,z=8,distance=..3,type=arrow]
execute as @n[tag=sgp.ci.accuracy_new,x=8,y=88,z=8,distance=..3,type=arrow] run function sgp.ci:perfect_accuracy/check {x:"-12290..-12200",y:"9960..10040",z:"12200..12290"}
function sgp.ci:perfect_accuracy/clear_projectiles
