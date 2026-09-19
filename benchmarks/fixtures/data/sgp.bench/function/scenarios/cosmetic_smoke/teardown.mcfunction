#> sgp.bench:scenarios/cosmetic_smoke/teardown
# `{first: int, last: int, players: int}`

$tag @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] remove sgp.particle.smoke
$tag @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] remove sgp.intensity.super_heavy
