#> sgp.bench:scenarios/systems/deaths/teardown
# `{first: int, last: int, players: int, period: int, victims: int}`

$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last),sgp.bench.deaths=1..}] run dummy @s respawn
$scoreboard players set @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.bench.deaths 0
$tag @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] remove sgp.bench.respawning
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] run function sgp.kits:clear
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] run function sgp.bench:scenarios/abilities/common/reset_actor_position
data remove storage sgp.bench:deaths args
scoreboard players set #deaths_phase sgp.bench 0
scoreboard players set #deaths_cursor sgp.bench 0
