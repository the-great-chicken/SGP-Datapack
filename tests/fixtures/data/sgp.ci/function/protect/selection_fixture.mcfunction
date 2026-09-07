#> sgp.ci:protect/selection_fixture
# Six participants awaiting selection, with one selector per team.

function sgp.ci:protect/roster
scoreboard players set #protect_phase sgp.dummy 1
scoreboard players set #king_rouge_chosen sgp.dummy 0
scoreboard players set #king_bleu_chosen sgp.dummy 0
tag PrRedKing remove sgp.roi_rouge
tag PrBlueKing remove sgp.roi_bleu
effect clear PrRedKing
effect clear PrBlueKing
summon marker ~4.5 ~1 ~4.5 {CustomName:"devenir_roi_rouge",Rotation:[0.0f,0.0f],Tags:["sgp.marker","sgp.ci.protect"]}
summon marker ~24.5 ~1 ~4.5 {CustomName:"devenir_roi_bleu",Rotation:[180.0f,0.0f],Tags:["sgp.marker","sgp.ci.protect"]}
setblock ~4 ~1 ~5 stone
setblock ~4 ~2 ~5 oak_sign
setblock ~24 ~1 ~3 stone
setblock ~24 ~2 ~3 oak_sign
execute as @e[tag=sgp.ci.protect,name=devenir_roi_rouge,distance=..40,type=marker] at @s run function sgp.majeurs:protect/setup_king_selector {side:rouge,team:rouge,name:Rouge,color:dark_red}
execute as @e[tag=sgp.ci.protect,name=devenir_roi_bleu,distance=..40,type=marker] at @s run function sgp.majeurs:protect/setup_king_selector {side:bleu,team:bleue,name:Bleu,color:dark_blue}
