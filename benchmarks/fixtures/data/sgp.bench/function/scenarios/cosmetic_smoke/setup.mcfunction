#> sgp.bench:scenarios/cosmetic_smoke/setup
# `{first: int, last: int, players: int}`

$tag @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] add sgp.particle.smoke
$tag @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] add sgp.intensity.super_heavy
