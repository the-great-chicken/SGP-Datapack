#> sgp.kits:cleave/returning_to_combat
# @dummy
# @environment sgp.ci:cleave/returning_to_combat
#
# A previously peaceful or out-of-game player becomes a valid sweep target when those restrictions end.

function sgp.ci:cleave/roster
await delay 61t
function sgp.ci:cleave/prepare
tp CleaveA ~10.5 ~1 ~13.5
tag CleaveA add sgp.peaceful
function sgp.ci:cleave/cast
assert entity @a[name=CleaveA,nbt={Health:20.0f}]
tag CleaveA remove sgp.peaceful
tag CleaveA remove sgp.in_game
function sgp.ci:cleave/cast
assert entity @a[name=CleaveA,nbt={Health:20.0f}]
tag CleaveA add sgp.in_game
function sgp.ci:cleave/cast
assert entity @a[name=CleaveA,nbt={Health:15.0f}]
