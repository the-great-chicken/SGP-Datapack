#> sgp.bench:scenarios/systems/locations/tick
# `{first: int, last: int, players: int, markers: int, occupied: int, exclusions: int, period: int}`
#
# The measured work is produced by minecraft:execute_repeating_functions, which
# already ran this tick (sgp.bench:tick is appended after it in the tick tag).
# period=0 measures steady-state membership only; otherwise every `period` ticks
# a quarter of the actors crosses the boundary of the first occupied location,
# exercising lieu/enter, lieu/leave and the actionbar-mixer segment churn.

$scoreboard players add #locations_marker_ticks sgp.bench $(markers)
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last),sgp.ab.location=1..}] run scoreboard players add #locations_inside_ticks sgp.bench 1

execute if score #locations_period sgp.bench matches 0 run return 0
scoreboard players add #locations_phase sgp.bench 1
execute if score #locations_phase sgp.bench < #locations_period sgp.bench run return 0
scoreboard players set #locations_phase sgp.bench 0

scoreboard players add #locations_outside sgp.bench 1
scoreboard players operation #locations_outside sgp.bench %= #locations_two sgp.bench
scoreboard players add #locations_crossings sgp.bench 1

# Both destinations are inside the pvp_arena radius and on the bedrock floor. z 26.5 is past
# the last occupied slab (z < 21 for occupied <= 5) and no empty marker lives at y 81.
$execute if score #locations_outside sgp.bench matches 1 run tp @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last),sgp.bench.clock=1}] 0.5 81.0 26.5 0 0
$execute if score #locations_outside sgp.bench matches 0 run tp @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last),sgp.bench.clock=1}] -20.5 81.0 -13.5 0 0
