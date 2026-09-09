#> sgp.ci:rays/scenarios/damage_multiple_targets

function sgp.ci:rays/prepare_damage
function sgp.ci:rays/update
execute unless entity @a[name=RayNear,nbt={Health:19.75f}] run function sgp.ci:rays/damage_diagnostics
execute unless entity @a[name=RayFar,nbt={Health:19.75f}] run function sgp.ci:rays/damage_diagnostics
execute store result score RayNear sgp.dummy run data get entity RayNear Health 1000
assert score RayNear sgp.dummy matches 19750
execute store result score RayFar sgp.dummy run data get entity RayFar Health 1000
assert score RayFar sgp.dummy matches 19750
assert entity @s[nbt={Health:20.0f}]
execute as RayNear on attacker run tag @s add sgp.ci.ray_attacker
assert entity @s[tag=sgp.ci.ray_attacker]
