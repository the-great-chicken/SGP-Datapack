#> sgp.bench:scenarios/events/major_protect/tick
# `{first: int, last: int, players: int}`
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)},tag=sgp.major_participant] run scoreboard players add #protect_participant_ticks sgp.bench 1
execute unless score #protect_phase sgp.dummy matches 2 run scoreboard players add #protect_stopped_ticks sgp.bench 1
execute unless score #protect_restart sgp.bench matches 1.. run return 0
scoreboard players add #protect_restart_phase sgp.bench 1
execute if score #protect_restart_phase sgp.bench < #protect_restart sgp.bench run return 0
scoreboard players set #protect_restart_phase sgp.bench 0
function sgp.bench:scenarios/events/major_protect/restart with storage sgp.bench:events protect
