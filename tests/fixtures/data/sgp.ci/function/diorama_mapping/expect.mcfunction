#> sgp.ci:diorama_mapping/expect
# {group, x, y, z}
$execute positioned $(x) $(y) $(z) run assert entity @e[tag=sgp.ci.mapping_$(group),distance=..0.002,type=mannequin]
