#> sgp.kits:cleave/cone_edges
# @dummy
# @environment sgp.ci:cleave/cone_edges
#
# Both sides of the sweep include targets near the cone edge and exclude targets farther to the sides.

function sgp.ci:cleave/roster
await delay 61t
function sgp.ci:cleave/prepare
tp CleaveA ~13.5 ~1 ~12.5
tp CleaveB ~7.5 ~1 ~12.5
tp CleaveC ~13.5 ~1 ~12.0
tp CleaveD ~7.5 ~1 ~12.0
function sgp.ci:cleave/cast
assert entity @a[name=CleaveA,nbt={Health:15.0f}]
assert entity @a[name=CleaveB,nbt={Health:15.0f}]
assert entity @a[name=CleaveC,nbt={Health:20.0f}]
assert entity @a[name=CleaveD,nbt={Health:20.0f}]
