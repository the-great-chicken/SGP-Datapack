#> sgp.ci:rays/prepare_damage

# Reset the arena and positions after the join-protection wait.
fill -12 88 -12 28 92 28 air
tp @s 8.5 88.0 8.5 0 0
tp RayNear 8.5 88.0 10.5
tp RayFar 8.5 88.0 14.5
assert entity @s[nbt={Health:20.0f}]
assert entity @a[name=RayNear,nbt={Health:20.0f}]
assert entity @a[name=RayFar,nbt={Health:20.0f}]
function sgp.ci:rays/start
