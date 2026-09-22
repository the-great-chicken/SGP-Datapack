#> sgp.bench:scenarios/events/major_hide_and_seek/teardown
# `{first: int, last: int, players: int}`
execute if entity @a[predicate=sgp.majeurs:hide_and_seek/ongoing] run function sgp.majeurs:hide_and_seek/_stop
function sgp.bench:scenarios/events/major_hide_and_seek/clear
$gamemode survival @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}]
$tag @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] remove sgp.major_spectator
$tag @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] remove sgp.major_participant
$team leave @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}]
$experience set @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] 0 levels
$experience set @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] 0 points
$effect clear @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}]
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] run function sgp.kits:clear
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] run function sgp.bench:scenarios/abilities/common/reset_actor_position
