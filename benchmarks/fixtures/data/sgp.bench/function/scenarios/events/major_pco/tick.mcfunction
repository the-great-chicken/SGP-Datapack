#> sgp.bench:scenarios/events/major_pco/tick
# `{first: int, last: int, players: int}`
#
# The measured work is sgp.majeurs:tick inside minecraft:execute_repeating_functions.
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)},tag=sgp.major_participant] run scoreboard players add #pco_participant_ticks sgp.bench 1
execute unless score #pco_phase sgp.dummy matches 2 run scoreboard players add #pco_stopped_ticks sgp.bench 1
