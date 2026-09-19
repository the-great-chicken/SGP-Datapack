#> sgp.bench:scenarios/abilities/bats/teardown
# `{first: int, last: int, players: int}`

$function sgp.bench:scenarios/abilities/common/teardown {first:$(first),last:$(last)}
kill @e[tag=sgp.bat_grenade]
$effect clear @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] minecraft:invisibility
$effect clear @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] minecraft:weakness
