#> sgp.ci:illusions_movement/expect
# {group, direction, x, y, z}

$execute unless entity @e[tag=sgp.ci.illusion_$(group),tag=sgp.direction_$(direction),distance=..32,type=mannequin] run function sgp.ci:illusions_movement/inspect_decoy with storage sgp.ci:illusions_movement identities.$(group).$(direction)
$assert entity @e[tag=sgp.ci.illusion_$(group),tag=sgp.direction_$(direction),distance=..32,type=mannequin]
$data modify storage sgp.ci:illusions_movement position_check set value {group:"$(group)",direction:"$(direction)",x:"$(x)",y:"$(y)",z:"$(z)",actual:[]}
$data modify storage sgp.ci:illusions_movement position_check.actual set from entity @n[tag=sgp.ci.illusion_$(group),tag=sgp.direction_$(direction),type=mannequin] Pos
$execute positioned $(x) $(y) $(z) unless entity @e[tag=sgp.ci.illusion_$(group),tag=sgp.direction_$(direction),distance=..0.01,type=mannequin] run function sgp.ci:illusions_movement/position_failure

$execute positioned $(x) $(y) $(z) run assert entity @e[tag=sgp.ci.illusion_$(group),tag=sgp.direction_$(direction),distance=..0.01,type=mannequin]
