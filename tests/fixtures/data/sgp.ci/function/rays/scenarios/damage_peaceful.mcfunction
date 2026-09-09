#> sgp.ci:rays/scenarios/damage_peaceful

function sgp.ci:rays/prepare_damage
tag RayNear add sgp.peaceful
function sgp.ci:rays/update
assert entity @a[name=RayNear,nbt={Health:20.0f}]
assert entity @a[name=RayFar,nbt={Health:19.75f}]
assert entity @s[nbt={Health:20.0f}]
