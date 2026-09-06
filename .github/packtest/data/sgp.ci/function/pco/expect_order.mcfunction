#> sgp.ci:pco/expect_order
# `{first, second}`
# Compare ordered entries explicitly; NBT list matching alone ignores order.

data modify storage sgp.ci:pco order set value {}
data modify storage sgp.ci:pco order.first set from storage sgp:data majeurs.pco.locations[0]
data modify storage sgp.ci:pco order.second set from storage sgp:data majeurs.pco.locations[1]
$assert data storage sgp.ci:pco order{first:{id:"$(first)"},second:{id:"$(second)"}}
assert not data storage sgp:data majeurs.pco.locations[2]
