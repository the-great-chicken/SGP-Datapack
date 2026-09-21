#> sgp.bench:scenarios/events/minor_event/tick
# `{first: int, last: int, players: int, event: int}`
scoreboard players add #minor_event_ticks sgp.bench 1
# Declared counter, written by the event tick functions below (kept here so the harness sees the holder).
scoreboard players add #minor_actions sgp.bench 0
scoreboard players add #minor_phase sgp.bench 1
execute if score #minor_event sgp.bench matches 1 run function sgp.bench:scenarios/events/minor_event/lootdrop/tick with storage sgp.bench:minor args
execute if score #minor_event sgp.bench matches 2 run function sgp.bench:scenarios/events/minor_event/confinement/tick with storage sgp.bench:minor args
execute if score #minor_event sgp.bench matches 3 run function sgp.bench:scenarios/events/minor_event/reflexes/tick with storage sgp.bench:minor args
execute if score #minor_event sgp.bench matches 4 run function sgp.bench:scenarios/events/minor_event/frenzy/tick with storage sgp.bench:minor args
execute if score #minor_event sgp.bench matches 5 run function sgp.bench:scenarios/events/minor_event/magic/tick with storage sgp.bench:minor args
execute if score #minor_event sgp.bench matches 6 run function sgp.bench:scenarios/events/minor_event/bounty/tick with storage sgp.bench:minor args
execute if score #minor_event sgp.bench matches 7 run function sgp.bench:scenarios/events/minor_event/swap/tick with storage sgp.bench:minor args
