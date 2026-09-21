#> sgp.bench:scenarios/events/minor_event/teardown
# `{first: int, last: int, players: int, event: int}`
execute if score #minor_event sgp.bench matches 1 run function sgp.bench:scenarios/events/minor_event/lootdrop/teardown with storage sgp.bench:minor args
execute if score #minor_event sgp.bench matches 2 run function sgp.bench:scenarios/events/minor_event/confinement/teardown with storage sgp.bench:minor args
execute if score #minor_event sgp.bench matches 3 run function sgp.bench:scenarios/events/minor_event/reflexes/teardown with storage sgp.bench:minor args
execute if score #minor_event sgp.bench matches 4 run function sgp.bench:scenarios/events/minor_event/frenzy/teardown with storage sgp.bench:minor args
execute if score #minor_event sgp.bench matches 5 run function sgp.bench:scenarios/events/minor_event/magic/teardown with storage sgp.bench:minor args
execute if score #minor_event sgp.bench matches 6 run function sgp.bench:scenarios/events/minor_event/bounty/teardown with storage sgp.bench:minor args
execute if score #minor_event sgp.bench matches 7 run function sgp.bench:scenarios/events/minor_event/swap/teardown with storage sgp.bench:minor args
function sgp.mineurs:_stop
schedule clear sgp.misc:second
scoreboard players set #second sgp.timer 0
scoreboard players set #timed_events_active sgp.dummy 0
scoreboard players set #events_mineurs_actifs sgp.dummy 0
$experience set @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] 0 levels
$experience set @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] 0 points
$effect clear @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}]
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] run function sgp.kits:clear
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] run function sgp.bench:scenarios/abilities/common/reset_actor_position
data remove storage sgp.bench:minor args
