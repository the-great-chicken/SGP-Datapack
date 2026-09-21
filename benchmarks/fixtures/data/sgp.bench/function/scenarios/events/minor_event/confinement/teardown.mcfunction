#> sgp.bench:scenarios/events/minor_event/confinement/teardown
# `{first, last, players, event}`
function sgp.mineurs:confinement/stop
$tag @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] remove sgp.unprotected
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] run attribute @s minecraft:max_health base reset
