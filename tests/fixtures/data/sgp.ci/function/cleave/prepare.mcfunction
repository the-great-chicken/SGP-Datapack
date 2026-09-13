#> sgp.ci:cleave/prepare
# Reset the caster and targets for one Cleave cast and verify everyone starts at full health.

tp @s ~10.5 ~1 ~10.5 0 0
tp @a[tag=sgp.ci.cleave_target] ~18.5 ~1 ~18.5
tag @s add sgp.in_game
tag @a[tag=sgp.ci.cleave_target] add sgp.in_game
assert entity @s[nbt={Health:20.0f}]
execute as @a[tag=sgp.ci.cleave_target] run assert entity @s[nbt={Health:20.0f}]
