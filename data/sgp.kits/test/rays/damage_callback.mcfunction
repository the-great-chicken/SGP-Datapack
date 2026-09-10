#> sgp.kits:rays/damage_callback
# @dummy
# @environment sgp.ci:rays/damage_callback
#
# The ray damage callback deals 0.25 damage and attributes it to the caster.

gamemode spectator @s
tp @s 8.0 88.0 8.0 0 0
await entity @s[predicate=sgp.ci:rays/area_loaded]
function sgp.ci:perfect_accuracy/ready
await entity @e[tag=sgp.ci.origin_ready,x=8,y=88,z=8,distance=..1,type=marker]
kill @e[tag=sgp.ci.origin_ready,type=marker]
function sgp.ci:rays/damage_roster
await delay 61t
# Isolate damage delivery from ray intersection detection.

function sgp.ci:rays/prepare_damage
tag @s add sgp.radiator
execute as RayNear at @s run function sgp.kits:abilities/rays/get_damaged
tag @s remove sgp.radiator
execute store result score RayNear sgp.dummy run data get entity RayNear Health 1000
assert score RayNear sgp.dummy matches 19750
execute as RayNear on attacker run tag @s add sgp.ci.ray_attacker
assert entity @s[tag=sgp.ci.ray_attacker]
assert entity @a[name=RayFar,nbt={Health:20.0f}]

