
#> sgp.bench:scenarios/abilities/cooldown/teardown
# `{first: int, last: int, players: int, period: int}`

kill @e[tag=sgp.dropped,type=item]
$function sgp.bench:scenarios/abilities/common/teardown {first:$(first),last:$(last)}
