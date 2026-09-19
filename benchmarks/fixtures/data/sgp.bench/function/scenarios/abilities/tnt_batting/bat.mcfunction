#> sgp.bench:scenarios/abilities/tnt_batting/bat
# `{first: int, last: int, players: int}`
# Each actor attacks the interaction spawned by its own charge. Baseline actors
# are seven blocks apart, while the linked interaction starts on the caster, so
# a two-block nearest-selector cannot select a neighbour's charge.

$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] at @s if entity @n[tag=sgp.tnt_interaction,distance=..2,type=interaction] run dummy @s attack @n[tag=sgp.tnt_interaction,distance=..2,type=interaction]
$scoreboard players add #tnt_bat_inputs sgp.bench $(players)
