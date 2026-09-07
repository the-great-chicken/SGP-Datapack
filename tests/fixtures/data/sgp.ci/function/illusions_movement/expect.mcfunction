#> sgp.ci:illusions_movement/expect
# {group, direction, x, y, z}

$execute positioned $(x) $(y) $(z) run assert entity @e[tag=sgp.ci.illusion_$(group),tag=sgp.direction_$(direction),distance=..0.01,type=mannequin]
