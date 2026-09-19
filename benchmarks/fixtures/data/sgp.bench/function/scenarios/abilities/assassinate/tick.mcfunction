#> sgp.bench:scenarios/abilities/assassinate/tick
# `{first: int, last: int, players: int}`
# Production ability tick routing does the workload; record exposure only.

$scoreboard players add #assassinate_player_ticks sgp.bench $(players)
