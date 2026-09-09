#> sgp.ci:cleave/scenarios/rotated_cast

function sgp.ci:cleave/prepare
tp @s ~10.5 ~1 ~10.5 90 0
tp CleaveA ~7.5 ~1 ~10.5
tp CleaveB ~13.5 ~1 ~10.5
function sgp.ci:cleave/cast
assert entity @a[name=CleaveA,nbt={Health:15.0f}]
assert entity @a[name=CleaveB,nbt={Health:20.0f}]
