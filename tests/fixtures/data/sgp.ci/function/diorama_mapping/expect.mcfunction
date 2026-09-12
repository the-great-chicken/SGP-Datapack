#> sgp.ci:diorama_mapping/expect
# `{group: fixture group, x, y, z: coordinate}`
#
# Assert a selected fixture mannequin is at the expected mapped world position.

$execute positioned $(x) $(y) $(z) run assert entity @e[tag=sgp.ci.mapping_$(group),distance=..0.002,type=mannequin]
