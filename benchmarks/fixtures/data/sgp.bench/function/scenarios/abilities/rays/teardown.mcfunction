#> sgp.bench:scenarios/abilities/rays/teardown
# `{first: int, last: int, players: int}`

$function sgp.bench:scenarios/abilities/common/teardown {first:$(first),last:$(last)}
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] run attribute @s minecraft:gravity modifier remove sgp.bench:rays_sparse_gravity
