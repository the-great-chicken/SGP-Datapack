#> sgp.ci:cleave/roster
# Build the Cleave arena with one caster and four stationary test targets.

fill ~ ~ ~ ~20 ~ ~20 stone
fill ~ ~1 ~ ~20 ~5 ~20 air
tag @s add sgp.ci.cleave_owner
dummy CleaveA spawn
dummy CleaveB spawn
dummy CleaveC spawn
dummy CleaveD spawn
tag CleaveA add sgp.ci.cleave_target
tag CleaveB add sgp.ci.cleave_target
tag CleaveC add sgp.ci.cleave_target
tag CleaveD add sgp.ci.cleave_target
gamemode survival @a[tag=sgp.ci.cleave_target]
gamemode survival @s
tp @s ~10.5 ~1 ~10.5 0 0
tp @a[tag=sgp.ci.cleave_target] ~18.5 ~1 ~18.5
