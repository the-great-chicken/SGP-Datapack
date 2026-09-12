#> sgp.kits:perfect_accuracy/potion_arc
# @dummy
# @environment sgp.ci:perfect_accuracy/potion_arc
#
# A splash potion follows horizontal aim while retaining an upward arc.

gamemode spectator @s
tp @s 8 88 8 0 0
await entity @s[predicate=sgp.ci:perfect_accuracy/area_loaded]
function sgp.ci:origin_arena/ready
await entity @e[tag=sgp.ci.origin_ready,x=8,y=88,z=8,distance=..1,type=marker]
kill @e[tag=sgp.ci.origin_ready,type=marker]
function sgp.ci:perfect_accuracy/clear_projectiles

tp @s 8 88 8 90 0
execute at @s run function sgp.ci:perfect_accuracy/create {type:splash_potion,motion:"[0.0,0.0,3.0]"}
assert entity @n[tag=sgp.ci.accuracy_new,x=8,y=88,z=8,distance=..3,type=splash_potion]
execute as @n[tag=sgp.ci.accuracy_new,x=8,y=88,z=8,distance=..3,type=splash_potion] run function sgp.kits:projectile/reset_velocity
assert entity @n[tag=sgp.ci.accuracy_new,x=8,y=88,z=8,distance=..3,type=splash_potion]
execute as @n[tag=sgp.ci.accuracy_new,x=8,y=88,z=8,distance=..3,type=splash_potion] run function sgp.ci:perfect_accuracy/check {x:"-5020..-4980",y:"1480..1520",z:"-20..20"}
kill @e[tag=sgp.ci.accuracy_new,type=splash_potion]
