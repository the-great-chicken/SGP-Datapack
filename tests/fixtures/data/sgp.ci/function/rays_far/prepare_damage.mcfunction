#> sgp.ci:rays_far/prepare_damage
# Reset the far arena and positions after the join-protection wait.
fill 988 88 988 1028 92 1028 air
tp @s 1008.5 88.0 1008.5 0 0
tp RayNear 1008.5 88.0 1010.5
tp RayFar 1024.6 88.0 1008.5
assert entity @s[nbt={Health:20.0f}]
assert entity @a[name=RayNear,nbt={Health:20.0f}]
assert entity @a[name=RayFar,nbt={Health:20.0f}]
function sgp.ci:rays/start
