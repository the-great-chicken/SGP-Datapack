#> sgp.bench:scenarios/events/major_pco/restart
# `{first: int, last: int}`
# Stop and start the event again inside the profiling window: the one-tick burst of a round end
# (synthetic deaths, kit cleanup) and a round start (teams, kits, teleports, titles for everyone).
function sgp.majeurs:pco/_stop
scoreboard players set #rounds sgp.dummy 0
function sgp.majeurs:pco/_start
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] run function sgp.bench:scenarios/abilities/common/reset_actor_position
$execute positioned 0 81 0 as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)},distance=..3] at @s run tp @s ~ ~ ~5
scoreboard players add #pco_restarts sgp.bench 1
