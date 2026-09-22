#> sgp.bench:scenarios/abilities/bats_detonating/measurement_reset
# `{first: int, last: int, players: int, period: int}`

# measurement_prepare already removed the warm-up swarm. Arm a deterministic
# first measured fire without altering the production ability lifecycle.
$scoreboard players set @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.bench.clock $(period)
$scoreboard players remove @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.bench.clock 1
