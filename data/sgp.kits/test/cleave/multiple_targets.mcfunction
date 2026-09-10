#> sgp.kits:cleave/multiple_targets
# @dummy
# @environment sgp.ci:cleave/multiple_targets
#
# One sweep hits every valid target in its cone, including off-center targets, but not targets to the side.

function sgp.ci:cleave/roster
await delay 61t
function sgp.ci:cleave/prepare
tp CleaveA ~10.5 ~1 ~13.5
tp CleaveB ~12.5 ~1 ~13.5
tp CleaveC ~8.5 ~1 ~13.5
tp CleaveD ~13.5 ~1 ~10.5
function sgp.ci:cleave/cast
assert entity @a[name=CleaveA,nbt={Health:15.0f}]
assert entity @a[name=CleaveB,nbt={Health:15.0f}]
assert entity @a[name=CleaveC,nbt={Health:15.0f}]
assert entity @a[name=CleaveD,nbt={Health:20.0f}]
