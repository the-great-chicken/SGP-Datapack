#> sgp.bench:scenarios/events/major_protect/setup
# `{first: int, last: int, players: int}`
#
# The two "devenir roi" markers (with the wall sign the selector rewrites one block up and
# one block in front), the two team spawns, then the production start and a forced king
# selection for each team. Everyone but the kings is sent to `respawn` by start_running;
# participants are then spread back over the actor grid with the kings kept away from it.

function sgp.bench:scenarios/events/major_protect/clear
setblock -11 82 -19 stone
setblock -11 82 -20 oak_wall_sign[facing=north]
summon marker -10.5 81 -20.5 {CustomName:"devenir_roi_rouge",Tags:["sgp.marker","sgp.bench.protect"],Rotation:[0f,0f]}
setblock 10 82 -19 stone
setblock 10 82 -20 oak_wall_sign[facing=north]
summon marker 10.5 81 -20.5 {CustomName:"devenir_roi_bleu",Tags:["sgp.marker","sgp.bench.protect"],Rotation:[0f,0f]}
summon marker -20.5 81 14.5 {CustomName:"protect_spawn_rouges",Tags:["sgp.marker","sgp.bench.protect"]}
summon marker 20.5 81 14.5 {CustomName:"protect_spawn_bleus",Tags:["sgp.marker","sgp.bench.protect"]}
scoreboard players set #protect_max_rounds sgp.dummy 1
scoreboard players set #rounds sgp.dummy 0
function sgp.majeurs:protect/_start
execute as @a[tag=sgp.major_participant,team=sgp.rouge,limit=1] run function sgp.majeurs:protect/select_king {side:rouge,team:rouge,name:Rouge,color:dark_red}
execute as @a[tag=sgp.major_participant,team=sgp.bleue,limit=1] run function sgp.majeurs:protect/select_king {side:bleu,team:bleue,name:Bleu,color:dark_blue}
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)},tag=!sgp.roi_rouge,tag=!sgp.roi_bleu] run function sgp.bench:scenarios/abilities/common/reset_actor_position
$execute positioned 0 81 0 as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)},distance=..3] at @s run tp @s ~ ~ ~5
scoreboard players set #protect_stopped_ticks sgp.bench 0
$scoreboard players set #protect_restart sgp.bench $(restart)
scoreboard players set #protect_restart_phase sgp.bench 0
$data modify storage sgp.bench:events protect set value {first:$(first),last:$(last)}
