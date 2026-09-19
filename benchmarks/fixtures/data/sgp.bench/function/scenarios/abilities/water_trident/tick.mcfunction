
#> sgp.bench:scenarios/abilities/water_trident/tick
# `{first: int, last: int, players: int, period: int}`

$scoreboard players add @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.bench.clock 1
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last),sgp.bench.clock=10}] at @s run function sgp.bench:scenarios/abilities/water_trident/leave_water
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last),sgp.bench.clock=15}] run function sgp.bench:scenarios/abilities/water_trident/return_home
$execute if entity @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last),sgp.bench.clock=$(period)..}] run function sgp.bench:scenarios/abilities/water_trident/fire {first:$(first),last:$(last),players:$(players)}
