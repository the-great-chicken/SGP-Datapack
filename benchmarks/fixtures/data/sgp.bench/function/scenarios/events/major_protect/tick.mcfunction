#> sgp.bench:scenarios/events/major_protect/tick
# `{first: int, last: int, players: int}`
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)},tag=sgp.major_participant] run scoreboard players add #protect_participant_ticks sgp.bench 1
execute unless score #protect_phase sgp.dummy matches 2 run scoreboard players add #protect_stopped_ticks sgp.bench 1
