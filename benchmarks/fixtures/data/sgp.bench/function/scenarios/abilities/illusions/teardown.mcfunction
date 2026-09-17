#> sgp.bench:scenarios/abilities/illusions/teardown
# `{first: int, last: int, players: int}`

kill @e[tag=sgp.illusion,type=mannequin]
kill @e[tag=sgp.illusion_center,type=marker]
$function sgp.bench:scenarios/abilities/common/teardown {first:$(first),last:$(last)}
