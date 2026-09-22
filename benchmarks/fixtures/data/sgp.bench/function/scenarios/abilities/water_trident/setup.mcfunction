#> sgp.bench:scenarios/abilities/water_trident/setup
# `{first: int, last: int, players: int, period: int}`

$function sgp.bench:scenarios/abilities/common/setup_kit {first:$(first),last:$(last),kit:"poseidon"}
$scoreboard players set @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.cooldown_ability 0
$scoreboard players set @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.bench.clock 0
