#> sgp.ci:cleave/scenarios/elevated_range

function sgp.ci:cleave/prepare
tp CleaveA ~10.5 ~4 ~13.5
tp CleaveB ~10.5 ~5.1 ~13.5
function sgp.ci:cleave/cast
assert entity @a[name=CleaveA,nbt={Health:15.0f}]
assert entity @a[name=CleaveB,nbt={Health:20.0f}]
