#> sgp.bench:scenarios/abilities/assassinate/teardown
# `{first: int, last: int, players: int}`

$tag @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] remove sgp.assassin
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] run attribute @s minecraft:knockback_resistance modifier remove sgp:assassinate
$effect clear @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] minecraft:resistance
$function sgp.bench:scenarios/abilities/common/teardown {first:$(first),last:$(last)}
