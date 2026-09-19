#> sgp.bench:scenarios/abilities/tnt_batting/tick
# `{first: int, last: int, players: int, period: int, bat_delay: int}`

$scoreboard players add @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.bench.clock 1
$execute if entity @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last),sgp.bench.clock=$(bat_delay)}] run function sgp.bench:scenarios/abilities/tnt_batting/bat {first:$(first),last:$(last),players:$(players)}
$execute if entity @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last),sgp.bench.clock=$(period)..}] run function sgp.bench:scenarios/abilities/tnt_batting/fire {first:$(first),last:$(last),players:$(players)}
