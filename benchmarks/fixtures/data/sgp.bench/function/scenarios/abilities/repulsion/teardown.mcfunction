#> sgp.bench:scenarios/abilities/repulsion/teardown
# `{first: int, last: int, players: int, period: int}`

$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] run attribute @s minecraft:gravity modifier remove sgp.kits:repulsion
kill @e[tag=sgp.repulsion_arrow,type=arrow]
kill @e[tag=sgp.dropped,type=item]
$function sgp.bench:scenarios/abilities/common/teardown {first:$(first),last:$(last)}
