#> sgp.bench:scenarios/systems/locations/teardown
# `{first: int, last: int, players: int, markers: int, occupied: int, exclusions: int, period: int}`

# Drop the location actionbar segments while the registry still exists (what sgp.misc:actionbar/clear does).
$tag @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] add sgp.ab.location_clear_target
function sgp.misc:loop_as_entity/init {list_location:"sgp:data markers_lists.location", command:"run function sgp.misc:actionbar/location_clear_for_target with entity @s data"}
$tag @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] remove sgp.ab.location_clear_target

# Removing sgp.lieu_<name> also removes every player row it held.
function sgp.bench:scenarios/systems/locations/clear

$team leave @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}]
team remove sgp.bench.locations
$scoreboard players set @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.bench.clock 0
$scoreboard players set @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.lieu_count 0
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] run function sgp.bench:scenarios/abilities/common/reset_actor_position
