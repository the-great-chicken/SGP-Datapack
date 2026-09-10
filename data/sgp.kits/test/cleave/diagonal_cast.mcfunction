#> sgp.kits:cleave/diagonal_cast
# @dummy
# @environment sgp.ci:cleave/diagonal_cast
#
# A diagonal sweep follows its caster rather than snapping to a cardinal direction.

function sgp.ci:cleave/roster
await delay 61t
function sgp.ci:cleave/prepare
tp @s ~10.5 ~1 ~10.5 45 0
tp CleaveA ~8.5 ~1 ~12.5
tp CleaveB ~12.5 ~1 ~12.5
tp CleaveC ~8.5 ~1 ~8.5
function sgp.ci:cleave/cast
assert entity @a[name=CleaveA,nbt={Health:15.0f}]
assert entity @a[name=CleaveB,nbt={Health:20.0f}]
assert entity @a[name=CleaveC,nbt={Health:20.0f}]
