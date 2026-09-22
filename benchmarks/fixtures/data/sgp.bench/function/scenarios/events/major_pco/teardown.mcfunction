#> sgp.bench:scenarios/events/major_pco/teardown
# `{first: int, last: int, players: int}`

# Production stop while the location markers still exist (restores the open cages, resets
# participants, leaves teams, cancels the pco schedules, common/stop).
execute if score #pco_phase sgp.dummy matches 1..2 run function sgp.majeurs:pco/_stop
function sgp.bench:scenarios/events/major_pco/clear
$gamemode survival @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}]
$tag @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] remove sgp.major_spectator
$tag @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] remove sgp.major_participant
$team leave @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}]
$experience set @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] 0 levels
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] run function sgp.kits:clear
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] run function sgp.bench:scenarios/abilities/common/reset_actor_position
