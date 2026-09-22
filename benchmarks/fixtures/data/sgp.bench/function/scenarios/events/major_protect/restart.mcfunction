#> sgp.bench:scenarios/events/major_protect/restart
# `{first: int, last: int}`
# Stop and start the event again inside the profiling window: the one-tick burst of a round end
# (synthetic deaths, kit cleanup) and a round start (teams, kits, teleports, titles for everyone).
function sgp.majeurs:protect/_stop
scoreboard players set #rounds sgp.dummy 0
function sgp.majeurs:protect/_start
execute as @a[tag=sgp.major_participant,team=sgp.rouge,limit=1] run function sgp.majeurs:protect/select_king {side:rouge,team:rouge,name:Rouge,color:dark_red}
execute as @a[tag=sgp.major_participant,team=sgp.bleue,limit=1] run function sgp.majeurs:protect/select_king {side:bleu,team:bleue,name:Bleu,color:dark_blue}
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)},tag=!sgp.roi_rouge,tag=!sgp.roi_bleu] run function sgp.bench:scenarios/abilities/common/reset_actor_position
$execute positioned 0 81 0 as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)},distance=..3] at @s run tp @s ~ ~ ~5
scoreboard players add #protect_restarts sgp.bench 1
