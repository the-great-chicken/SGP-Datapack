#> sgp.ci:kill_effects/record_attacker
# Deal one real point of damage so vanilla records the current player as the victim's attacker.

damage EffectVictim 1 minecraft:player_attack by @s
assert entity @a[name=EffectVictim,nbt={Health:19.0f}]
execute as EffectVictim on attacker run tag @s add sgp.ci.effect_attacker
assert entity @s[tag=sgp.ci.effect_attacker]
