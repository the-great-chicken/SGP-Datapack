#> sgp.ci:perfect_accuracy/create
# `{type: projectile entity type, motion: 3-double Motion list}`
#
# Create a projectile owned by the executing shooter, before its first physics tick.

$execute store success score #ci.accuracy.summoned sgp.dummy run summon $(type) ~ ~2 ~ {Tags:["sgp.ci.accuracy","sgp.ci.accuracy_new"],Motion:$(motion)}
assert score #ci.accuracy.summoned sgp.dummy matches 1
$execute store result score #ci.accuracy.visible_before_owner sgp.dummy if entity @e[tag=sgp.ci.accuracy_new,distance=..3,type=$(type)]
assert score #ci.accuracy.visible_before_owner sgp.dummy matches 1
$data modify entity @n[tag=sgp.ci.accuracy_new,distance=..3,type=$(type)] Owner set from entity @s UUID
$execute store result score #ci.accuracy.visible_after_owner sgp.dummy if entity @e[tag=sgp.ci.accuracy_new,distance=..3,type=$(type)]
assert score #ci.accuracy.visible_after_owner sgp.dummy matches 1
