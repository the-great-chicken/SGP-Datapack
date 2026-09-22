#> sgp.bench:scenarios/melee/teardown
# `{first: int, last: int, players: int, period: int}`

$tag @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] remove sgp.bench.melee.left
$tag @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] remove sgp.bench.melee.right
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] run attribute @s minecraft:max_health base set 20
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] run attribute @s minecraft:knockback_resistance base set 0
$scoreboard players reset @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.bench.clock
