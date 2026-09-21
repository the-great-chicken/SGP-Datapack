#> sgp.bench:scenarios/events/major_hide_and_seek/restart
# `{first: int, last: int}`
# Stop and start the event again inside the profiling window: the one-tick burst of a round end
# (synthetic deaths, kit cleanup) and a round start (teams, kits, teleports, titles for everyone).
execute if entity @a[predicate=sgp.majeurs:hide_and_seek/ongoing] run function sgp.majeurs:hide_and_seek/_stop
scoreboard players set #rounds sgp.dummy 0
function sgp.majeurs:hide_and_seek/_start
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] run function sgp.bench:scenarios/abilities/common/reset_actor_position
scoreboard players add #hns_restarts sgp.bench 1
