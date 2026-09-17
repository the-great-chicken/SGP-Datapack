
#> sgp.bench:scenarios/abilities/cooldown/fire
# `{first: int, last: int, players: int}`

$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] run dummy @s drop
$scoreboard players add #cooldown_drop_inputs sgp.bench $(players)
$scoreboard players set @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.bench.clock 0
