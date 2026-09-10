#> sgp.kits:cleave/front_and_rear
# @dummy
# @environment sgp.ci:cleave/front_and_rear
#
# A sweep hits players in front, leaves players behind safe, and attributes the hit to its caster.

function sgp.ci:cleave/roster
await delay 61t
function sgp.ci:cleave/prepare
tp CleaveA ~10.5 ~1 ~13.5
tp CleaveB ~10.5 ~1 ~7.5
function sgp.ci:cleave/cast
assert entity @a[name=CleaveA,nbt={Health:15.0f}]
assert entity @a[name=CleaveB,nbt={Health:20.0f}]
execute as CleaveA on attacker run tag @s add sgp.ci.cleave_attributed
assert entity @s[tag=sgp.ci.cleave_attributed]
