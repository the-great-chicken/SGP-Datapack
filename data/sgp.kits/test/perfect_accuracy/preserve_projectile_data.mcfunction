#> sgp.kits:perfect_accuracy/preserve_projectile_data
# @dummy
# @environment sgp.ci:perfect_accuracy/preserve_projectile_data
#
# Trajectory correction preserves the projectile position, owner, damage and stored weapon.

gamemode spectator @s
tp @s 8.0 88.0 8.0 0 0
await entity @s[predicate=sgp.ci:perfect_accuracy/area_loaded]
function sgp.ci:origin_arena/ready
await entity @e[tag=sgp.ci.origin_ready,x=8,y=88,z=8,distance=..1,type=marker]
kill @e[tag=sgp.ci.origin_ready,type=marker]
function sgp.ci:perfect_accuracy/clear_projectiles

tp @s 8.0 88.0 8.0 90 0
execute at @s run function sgp.ci:perfect_accuracy/create {type:arrow,motion:"[0.0,0.0,2.0]"}
data merge entity @n[tag=sgp.ci.accuracy_new,x=8,y=88,z=8,distance=..3,type=arrow] {damage:7.0d,weapon:{id:"minecraft:bow",count:1,components:{"minecraft:damage":9,"minecraft:custom_data":{ci_keep:4}}}}
data modify storage sgp.ci:accuracy before_pos set from entity @n[tag=sgp.ci.accuracy_new,x=8,y=88,z=8,distance=..3,type=arrow] Pos
assert entity @n[tag=sgp.ci.accuracy_new,x=8,y=88,z=8,distance=..3,type=arrow]
execute as @n[tag=sgp.ci.accuracy_new,x=8,y=88,z=8,distance=..3,type=arrow] run function sgp.kits:projectile/reset_velocity
assert entity @n[tag=sgp.ci.accuracy_new,x=8,y=88,z=8,distance=..3,type=arrow]
execute as @n[tag=sgp.ci.accuracy_new,x=8,y=88,z=8,distance=..3,type=arrow] run function sgp.ci:perfect_accuracy/check {x:"-20020..-19980",y:"-20..20",z:"-20..20"}
assert entity @n[tag=sgp.ci.accuracy_new,x=8,y=88,z=8,distance=..3,nbt={damage:7.0d,weapon:{id:"minecraft:bow",components:{"minecraft:damage":9,"minecraft:custom_data":{ci_keep:4}}}},type=arrow]
data modify storage sgp.ci:accuracy after_pos set from entity @n[tag=sgp.ci.accuracy_new,x=8,y=88,z=8,distance=..3,type=arrow] Pos
execute store success score #ci.accuracy.moved sgp.dummy run data modify storage sgp.ci:accuracy after_pos set from storage sgp.ci:accuracy before_pos
assert score #ci.accuracy.moved sgp.dummy matches 0
execute as @n[tag=sgp.ci.accuracy_new,x=8,y=88,z=8,distance=..3,type=arrow] on origin run tag @s add sgp.ci.accuracy_owner
assert entity @s[tag=sgp.ci.accuracy_owner]
function sgp.ci:perfect_accuracy/clear_projectiles
