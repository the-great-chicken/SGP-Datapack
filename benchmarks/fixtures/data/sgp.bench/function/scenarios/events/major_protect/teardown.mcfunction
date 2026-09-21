#> sgp.bench:scenarios/events/major_protect/teardown
# `{first: int, last: int, players: int}`
execute if score #protect_phase sgp.dummy matches 1..2 run function sgp.majeurs:protect/_stop
function sgp.bench:scenarios/events/major_protect/clear
$gamemode survival @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}]
$tag @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] remove sgp.major_spectator
$tag @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] remove sgp.major_participant
$tag @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] remove sgp.roi_rouge
$tag @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] remove sgp.roi_bleu
$team leave @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}]
$experience set @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] 0 levels
$effect clear @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}]
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] run function sgp.kits:clear
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] run function sgp.bench:scenarios/abilities/common/reset_actor_position
