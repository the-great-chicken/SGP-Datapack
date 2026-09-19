#> sgp.bench:scenarios/abilities/rays/teardown
# `{first: int, last: int, players: int}`

$tag @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] remove sgp.peaceful
$function sgp.bench:scenarios/abilities/common/teardown {first:$(first),last:$(last)}
