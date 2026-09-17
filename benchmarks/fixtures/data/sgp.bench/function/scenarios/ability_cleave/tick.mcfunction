#> sgp.bench:scenarios/ability_cleave/tick
# `{first: int, last: int, players: int, period: int}`

$scoreboard players add @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.bench.clock 1
$execute if entity @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last),sgp.bench.clock=$(period)..}] run function sgp.bench:scenarios/ability_cleave/fire {first:$(first),last:$(last),players:$(players)}
