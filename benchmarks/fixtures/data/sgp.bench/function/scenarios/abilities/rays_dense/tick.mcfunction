
#> sgp.bench:scenarios/abilities/rays_dense/tick
# `{first: int, last: int, players: int}`

# Production rays have already applied their real /damage/title/particle path.
$effect give @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] minecraft:instant_health 1 10 true
$scoreboard players add #rays_dense_player_ticks sgp.bench $(players)
