#> sgp.bench:scenarios/abilities/common/teardown
# `{first: int, last: int}`

$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] at @s run function sgp.kits:abilities/end_active
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] run attribute @s minecraft:max_health base set 20
$scoreboard players reset @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.bench.clock
