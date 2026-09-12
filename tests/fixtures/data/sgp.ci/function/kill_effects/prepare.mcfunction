#> sgp.ci:kill_effects/prepare
# Reset caster and victim positions and verify the victim starts at full health.

tp @s ~1.5 ~1 ~1.5
tp EffectVictim ~5.5 ~1 ~5.5
assert entity @a[name=EffectVictim,nbt={Health:20.0f}]
