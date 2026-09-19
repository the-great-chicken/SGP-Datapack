#> sgp.bench:scenarios/abilities/tnt_batting/fire
# `{first: int, last: int, players: int}`

$scoreboard players set @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.cooldown_ability 0
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] run dummy @s drop
$scoreboard players add #tnt_bat_drops sgp.bench $(players)
scoreboard players add #tnt_bat_waves sgp.bench 1
$scoreboard players set @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.bench.clock 0
