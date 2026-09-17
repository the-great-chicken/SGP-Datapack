#> sgp.bench:scenarios/abilities/tnt_batting/teardown
# `{first: int, last: int, players: int, period: int, bat_delay: int}`

schedule clear sgp.kits:abilities/tnt/explode_at
kill @e[tag=sgp.tnt,type=tnt]
kill @e[tag=sgp.tnt_interaction,type=interaction]
kill @e[tag=sgp.fire_explosion,type=marker]
kill @e[tag=sgp.dropped,type=item]
$function sgp.bench:scenarios/abilities/common/teardown {first:$(first),last:$(last)}
