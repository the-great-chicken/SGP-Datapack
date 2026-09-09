#> sgp.ci:cleave/scenarios/cone_edges

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
