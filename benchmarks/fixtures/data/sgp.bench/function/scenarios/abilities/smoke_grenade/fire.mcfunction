#> sgp.bench:scenarios/abilities/smoke_grenade/fire
# `{first: int, last: int, players: int}`

$scoreboard players set @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.cooldown_ability 0
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] run dummy @s drop
$scoreboard players add #smoke_grenade_drop_inputs sgp.bench $(players)
scoreboard players add #smoke_grenade_waves sgp.bench 1
$scoreboard players set @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.bench.clock 0
