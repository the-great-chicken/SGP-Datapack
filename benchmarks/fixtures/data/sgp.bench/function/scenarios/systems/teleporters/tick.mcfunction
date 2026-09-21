#> sgp.bench:scenarios/systems/teleporters/tick
# `{first: int, last: int, players: int, markers: int, standing: int}`
#
# The measured work is produced by minecraft:execute_repeating_functions, which
# already ran this tick (sgp.bench:tick is appended after it in the tick tag).

$scoreboard players add #teleporters_marker_ticks sgp.bench $(markers)
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)},tag=sgp.to_teleport] run scoreboard players add #teleporters_waiting_ticks sgp.bench 1
