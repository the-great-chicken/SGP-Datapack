#> sgp.ci:cleave/cast
# Resolve Cleave from the current caster and verify the cast leaves no attacker bookkeeping behind.

execute at @s run function sgp.kits:abilities/cleave/resolve_hits
assert entity @s[nbt={Health:20.0f}]
assert not entity @a[tag=sgp.attacker]
