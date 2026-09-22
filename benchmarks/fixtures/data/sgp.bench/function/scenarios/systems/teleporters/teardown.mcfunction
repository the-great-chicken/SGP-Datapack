#> sgp.bench:scenarios/systems/teleporters/teardown
# `{first: int, last: int, players: int, markers: int, standing: int}`

$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)},tag=sgp.to_teleport] run function sgp.world:teleporter/out_of_range
function sgp.bench:scenarios/systems/teleporters/clear
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] run function sgp.bench:scenarios/abilities/common/reset_actor_position
