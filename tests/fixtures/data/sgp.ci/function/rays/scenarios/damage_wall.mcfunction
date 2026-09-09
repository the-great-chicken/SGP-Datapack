#> sgp.ci:rays/scenarios/damage_wall

function sgp.ci:rays/prepare_damage
setblock 8 88 12 stone
function sgp.ci:rays/update
assert entity @a[name=RayNear,nbt={Health:19.75f}]
assert entity @a[name=RayFar,nbt={Health:20.0f}]
assert entity @s[nbt={Health:20.0f}]
