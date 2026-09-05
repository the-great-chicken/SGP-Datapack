#> sgp.majeurs:protect/select_king
# `{side, team, name, color}`
#
# Register the interacting participant as their team's king.

execute unless score #protect_phase sgp.dummy matches 1 run return 0
$execute unless score #king_$(side)_chosen sgp.dummy matches 0 run return 0
$execute unless entity @s[tag=sgp.major_participant,team=sgp.$(team)] run return 0

$tag @s add sgp.roi_$(side)
$scoreboard players set #king_$(side)_chosen sgp.dummy 1
$data merge entity @e[tag=sgp.protect.king_selector.$(side),limit=1,type=interaction] {response:false,width:0.0f,height:0.0f}
$execute as @e[tag=sgp.marker,name="devenir_roi_$(side)",limit=1,type=marker] at @s run data modify block ^ ^1 ^1 {} merge value {front_text:{messages:['[""]','["",{text:"ROI",bold:true,color:$(color)}]','["",{text:"CHOISI",bold:true,color:$(color)}]','[""]']}}

$tellraw @a[tag=sgp.in_game] ["",{selector:"@s",color:"$(color)",bold:true},{text:" est le roi ",color:gold},{text:"$(name)",color:"$(color)",bold:true}]
$title @a[tag=sgp.in_game] subtitle [{text:" est le roi ",color:gold},{text:"$(name)",color:"$(color)",bold:true}]
$title @a[tag=sgp.in_game] title [{selector:"@s",color:"$(color)",bold:true}]

execute if score #king_rouge_chosen sgp.dummy matches 1 if score #king_bleu_chosen sgp.dummy matches 1 run function sgp.majeurs:protect/start_running
