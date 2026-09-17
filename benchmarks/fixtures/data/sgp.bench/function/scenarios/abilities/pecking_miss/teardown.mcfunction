
#> sgp.bench:scenarios/abilities/pecking_miss/teardown
# `{first: int, last: int, players: int, period: int}`

$tag @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] remove sgp.peaceful
kill @e[tag=sgp.dropped,type=item]
$function sgp.bench:scenarios/abilities/common/teardown {first:$(first),last:$(last)}
