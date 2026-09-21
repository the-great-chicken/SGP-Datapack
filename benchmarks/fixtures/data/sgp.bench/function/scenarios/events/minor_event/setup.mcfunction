#> sgp.bench:scenarios/events/minor_event/setup
# `{first: int, last: int, players: int, event: int}`
#
# Kits roster, scheduler off, then the selected event's own setup (each event file lives in
# its own folder: setup, tick, teardown; all receive the scenario arguments).

scoreboard players set #events_mineurs_actifs sgp.dummy 0
$function sgp.bench:scenarios/kits_idle/setup {first:$(first),last:$(last),players:$(players)}
$scoreboard players set #minor_event sgp.bench $(event)
$data modify storage sgp.bench:minor args set value {first:$(first),last:$(last),players:$(players),event:$(event)}
scoreboard players set #minor_phase sgp.bench 0
scoreboard players set #minor_c20 sgp.bench 20
scoreboard players set #minor_c40 sgp.bench 40
scoreboard players set #minor_c60 sgp.bench 60
scoreboard players set #minor_c90 sgp.bench 90
execute if score #minor_event sgp.bench matches 1 run function sgp.bench:scenarios/events/minor_event/lootdrop/setup with storage sgp.bench:minor args
execute if score #minor_event sgp.bench matches 2 run function sgp.bench:scenarios/events/minor_event/confinement/setup with storage sgp.bench:minor args
execute if score #minor_event sgp.bench matches 3 run function sgp.bench:scenarios/events/minor_event/reflexes/setup with storage sgp.bench:minor args
execute if score #minor_event sgp.bench matches 4 run function sgp.bench:scenarios/events/minor_event/frenzy/setup with storage sgp.bench:minor args
execute if score #minor_event sgp.bench matches 5 run function sgp.bench:scenarios/events/minor_event/magic/setup with storage sgp.bench:minor args
execute if score #minor_event sgp.bench matches 6 run function sgp.bench:scenarios/events/minor_event/bounty/setup with storage sgp.bench:minor args
