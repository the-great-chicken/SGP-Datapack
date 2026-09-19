
#> sgp.bench:scenarios/abilities/cleave/tick
# `{first: int, last: int, players: int, period: int}`

# Production ability processing already happened earlier in the server tick.
# Heal after its real damage callbacks so dense targets survive the whole run.
$effect give @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] minecraft:instant_health 1 10 true
$scoreboard players add @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.bench.clock 1
$execute if entity @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last),sgp.bench.clock=$(period)..}] run function sgp.bench:scenarios/abilities/cleave/fire {first:$(first),last:$(last),players:$(players)}
