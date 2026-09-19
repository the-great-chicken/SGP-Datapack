
#> sgp.bench:scenarios/abilities/rays_dense/teardown
# `{first: int, last: int, players: int}`

$function sgp.bench:scenarios/abilities/common/teardown {first:$(first),last:$(last)}
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] run attribute @s minecraft:knockback_resistance modifier remove sgp.bench:stabilize
$team leave @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}]
team remove sgp.bench.rays
