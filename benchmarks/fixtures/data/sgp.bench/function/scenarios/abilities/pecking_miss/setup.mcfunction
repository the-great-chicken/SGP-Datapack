
#> sgp.bench:scenarios/abilities/pecking_miss/setup
# `{first: int, last: int, players: int, period: int}`

$function sgp.bench:scenarios/abilities/common/setup_drop {first:$(first),last:$(last),kit:"pigeon"}
$tag @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] add sgp.peaceful
