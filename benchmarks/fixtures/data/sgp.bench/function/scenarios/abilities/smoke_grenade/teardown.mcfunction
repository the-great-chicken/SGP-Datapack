#> sgp.bench:scenarios/abilities/smoke_grenade/teardown
# `{first: int, last: int, players: int, period: int}`

kill @e[tag=sgp.smoke_grenade,type=snowball]
kill @e[tag=sgp.smoke_visual,type=item_display]
kill @e[tag=sgp.dropped,type=item]
$function sgp.bench:scenarios/abilities/common/teardown {first:$(first),last:$(last)}
