#> sgp.ci:kill_effects/record_attacker

damage EffectVictim 1 minecraft:player_attack by @s
assert entity @a[name=EffectVictim,nbt={Health:19.0f}]
execute as EffectVictim on attacker run tag @s add sgp.ci.effect_attacker
assert entity @s[tag=sgp.ci.effect_attacker]
