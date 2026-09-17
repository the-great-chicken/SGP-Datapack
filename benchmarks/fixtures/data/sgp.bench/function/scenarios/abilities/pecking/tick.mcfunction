
#> sgp.bench:scenarios/abilities/pecking/tick
# `{first: int, last: int, players: int}`

# Heal after production Pecking damage, retaining all targets for the full run.
$effect give @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] minecraft:instant_health 1 10 true
$scoreboard players add #pecking_player_ticks sgp.bench $(players)
