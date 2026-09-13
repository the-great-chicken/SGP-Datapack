#> sgp.kits:cleave/range
# @dummy
# @environment sgp.ci:cleave/range
#
# The sweep reaches five blocks but does not damage a player just beyond its reach.

function sgp.ci:cleave/roster
await delay 61t
function sgp.ci:cleave/prepare
tp CleaveA ~10.5 ~1 ~15.5
tp CleaveB ~10.5 ~1 ~15.6
function sgp.ci:cleave/cast
assert entity @a[name=CleaveA,nbt={Health:15.0f}]
assert entity @a[name=CleaveB,nbt={Health:20.0f}]
