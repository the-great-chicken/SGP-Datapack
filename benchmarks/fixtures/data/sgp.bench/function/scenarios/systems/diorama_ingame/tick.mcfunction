#> sgp.bench:scenarios/systems/diorama_ingame/tick
# `{first: int, last: int, players: int, lobby: int}`
# The measured work is sgp.diorama:tick/main and the piercing-weapon pass inside
# minecraft:execute_repeating_functions.
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)},tag=sgp.has_small_mannequin_99002] run scoreboard players add #diorama_small_ticks sgp.bench 1
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)},tag=sgp.has_giant_mannequin_99002] run scoreboard players add #diorama_giant_ticks sgp.bench 1
