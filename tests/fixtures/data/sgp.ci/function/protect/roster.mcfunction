#> sgp.ci:protect/roster
# Two kings, two allies per team, and the test dummy observing the round.

execute as @a[tag=sgp.ci.protect_actor] run dummy @s leave
function #bs.schedule:cancel_all {with:{id:"major_event"}}
kill @e[tag=sgp.ci.protect,type=marker]
scoreboard players set #protect_phase sgp.dummy 2
scoreboard players set #rounds sgp.dummy 0
scoreboard players set #protect_max_rounds sgp.dummy 1
scoreboard players set #king_rouge_chosen sgp.dummy 1
scoreboard players set #king_bleu_chosen sgp.dummy 1
scoreboard players set #mort_roi_rouge_annoncee sgp.dummy 0
scoreboard players set #mort_roi_bleue_annoncee sgp.dummy 0

fill ~ ~1 ~ ~35 ~4 ~12 air
fill ~ ~ ~ ~35 ~ ~12 stone
summon marker ~30.5 ~1 ~0.5 {CustomName:"respawn",Tags:["sgp.marker","sgp.ci.protect"]}
summon marker ~10.5 ~1 ~8.5 {CustomName:"pvp_arena",Tags:["sgp.marker","sgp.ci.protect"]}
dummy PrRedKing spawn
dummy PrRedA spawn
dummy PrRedB spawn
dummy PrBlueKing spawn
dummy PrBlueA spawn
dummy PrBlueB spawn
tag PrRedKing add sgp.ci.protect_actor
tag PrRedA add sgp.ci.protect_actor
tag PrRedB add sgp.ci.protect_actor
tag PrBlueKing add sgp.ci.protect_actor
tag PrBlueA add sgp.ci.protect_actor
tag PrBlueB add sgp.ci.protect_actor
tag @a[tag=sgp.ci.protect_actor] add sgp.major_participant
team join sgp.rouge PrRedKing
team join sgp.rouge PrRedA
team join sgp.rouge PrRedB
team join sgp.bleue PrBlueKing
team join sgp.bleue PrBlueA
team join sgp.bleue PrBlueB
tag PrRedKing add sgp.roi_rouge
tag PrBlueKing add sgp.roi_bleu
tag @s add sgp.ci.protect_actor
tag @a[tag=sgp.ci.protect_actor] add sgp.in_game
gamemode creative @a[tag=sgp.ci.protect_actor]
execute as @a[tag=sgp.ci.protect_actor] run attribute @s minecraft:max_health base set 20
effect give PrRedKing minecraft:health_boost infinite 4 true
effect give PrBlueKing minecraft:health_boost infinite 4 true
tp PrRedKing ~0.5 ~1 ~0.5
tp PrRedA ~2.5 ~1 ~0.5
tp PrRedB ~3.5 ~1 ~0.5
tp PrBlueKing ~20.5 ~1 ~0.5
tp PrBlueA ~22.5 ~1 ~0.5
tp PrBlueB ~23.5 ~1 ~0.5
tp @s ~10.5 ~1 ~10.5
