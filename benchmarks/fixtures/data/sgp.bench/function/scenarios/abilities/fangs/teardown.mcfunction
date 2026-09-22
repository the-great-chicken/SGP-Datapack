#> sgp.bench:scenarios/abilities/fangs/teardown
# `{first: int, last: int, players: int, period: int}`

kill @e[type=evoker_fangs]
kill @e[tag=sgp.dropped,type=item]
$function sgp.bench:scenarios/abilities/common/teardown {first:$(first),last:$(last)}
