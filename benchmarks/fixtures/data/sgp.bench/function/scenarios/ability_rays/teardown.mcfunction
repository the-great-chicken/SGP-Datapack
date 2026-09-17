#> sgp.bench:scenarios/ability_rays/teardown
# `{first: int, last: int, players: int}`

$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] run function sgp.kits:abilities/end_active
$tag @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] remove sgp.peaceful
