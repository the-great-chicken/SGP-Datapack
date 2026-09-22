#> sgp.bench:scenarios/melee/fire
# `{first: int, last: int, players: int}`

$execute as @a[tag=sgp.bench.melee.left,scores={sgp.bench=$(first)..$(last)}] at @s run dummy @s attack @p[tag=sgp.bench.melee.right,scores={sgp.bench=$(first)..$(last)},distance=0.1..3]
$execute as @a[tag=sgp.bench.melee.right,scores={sgp.bench=$(first)..$(last)}] at @s run dummy @s attack @p[tag=sgp.bench.melee.left,scores={sgp.bench=$(first)..$(last)},distance=0.1..3]
$effect give @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] minecraft:instant_health 1 6 true
$scoreboard players add #melee_attack_inputs sgp.bench $(players)
scoreboard players add #melee_waves sgp.bench 1
$scoreboard players set @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.bench.clock 0
