#> sgp.ci:rays/scenarios/damage_callback
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
