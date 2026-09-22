#> sgp.bench:scenarios/systems/diorama_ingame/teardown
# `{first: int, last: int, players: int, lobby: int}`
$function sgp.bench:scenarios/systems/diorama_ingame/clear {first:$(first),last:$(last)}
$team leave @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}]
team remove sgpbenchdio
$clear @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}]
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] run function sgp.bench:scenarios/abilities/common/reset_actor_position
