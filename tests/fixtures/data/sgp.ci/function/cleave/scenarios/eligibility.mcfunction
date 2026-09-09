#> sgp.ci:cleave/scenarios/eligibility

function sgp.ci:cleave/prepare
tp CleaveA ~10.5 ~1 ~13.5
tp CleaveB ~11.5 ~1 ~13.5
tp CleaveC ~9.5 ~1 ~13.5
tag CleaveB add sgp.peaceful
tag CleaveC remove sgp.in_game
function sgp.ci:cleave/cast
assert entity @a[name=CleaveA,nbt={Health:15.0f}]
assert entity @a[name=CleaveB,nbt={Health:20.0f}]
assert entity @a[name=CleaveC,nbt={Health:20.0f}]
