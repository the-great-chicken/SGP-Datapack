#> sgp.ci:kill_effects/roster
# Build a clean arena with one creative killer and one survival victim.

fill ~ ~ ~ ~16 ~ ~12 stone
fill ~ ~1 ~ ~16 ~5 ~12 air
gamemode creative @s
tp @s ~1.5 ~1 ~1.5
dummy EffectVictim spawn
gamemode survival EffectVictim
tp EffectVictim ~5.5 ~1 ~5.5
