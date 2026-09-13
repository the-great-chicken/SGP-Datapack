#> sgp.kits:cleave/elevated_range
# @dummy
# @environment sgp.ci:cleave/elevated_range
#
# Sweep reach includes vertical separation, so a higher target outside the five-block sphere remains safe.

function sgp.ci:cleave/roster
await delay 61t
function sgp.ci:cleave/prepare
tp CleaveA ~10.5 ~4 ~13.5
tp CleaveB ~10.5 ~5.1 ~13.5
function sgp.ci:cleave/cast
assert entity @a[name=CleaveA,nbt={Health:15.0f}]
assert entity @a[name=CleaveB,nbt={Health:20.0f}]
