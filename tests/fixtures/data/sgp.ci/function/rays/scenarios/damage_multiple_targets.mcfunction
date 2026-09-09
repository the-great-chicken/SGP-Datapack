#> sgp.ci:rays/scenarios/damage_multiple_targets

function sgp.ci:rays/prepare_damage
function sgp.ci:rays/update
assert entity @a[name=RayNear,nbt={Health:19.75f}]
assert entity @a[name=RayFar,nbt={Health:19.75f}]
assert entity @s[nbt={Health:20.0f}]
execute as RayNear on attacker run tag @s add sgp.ci.ray_attacker
assert entity @s[tag=sgp.ci.ray_attacker]
