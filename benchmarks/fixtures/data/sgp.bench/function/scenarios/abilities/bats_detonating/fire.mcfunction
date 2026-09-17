
#> sgp.bench:scenarios/abilities/bats_detonating/fire
# `{first: int, last: int, players: int}`

# End the preceding visibility/equipment lifecycle before intentionally forcing
# another activation. The common cooldown cost is benchmarked separately.
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] at @s run function sgp.kits:abilities/end_active
$scoreboard players set @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.cooldown_ability 0
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] run dummy @s drop
$scoreboard players add #bats_detonate_inputs sgp.bench $(players)
scoreboard players add #bats_detonate_waves sgp.bench 1
$scoreboard players set @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.bench.clock 0
