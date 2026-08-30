execute run tellraw @a[tag=sgp.in_game] [{text:"Lancement de l'event Proteger le Roi...", color:gold, bold:true}]

function sgp.majeurs:common/start

scoreboard players set #kings_chosen sgp.dummy 0
scoreboard players set #king_rouge_chosen sgp.dummy 0
scoreboard players set #king_bleu_chosen sgp.dummy 0

execute as @e[type=marker,tag=sgp.marker,name="devenir_roi_rouge",limit=1] at @s run data modify block ^ ^1 ^1 {} merge value {front_text:{messages:['[""]','["",{text:"DEVENIR",bold:true,color:dark_red}]','[{text:"LE ROI",bold:true,color:dark_red,click_event:{action:run_command,command:"trigger sgp.devenir_roi_rouge"}}]','[""]']}}
execute as @e[type=marker,tag=sgp.marker,name="devenir_roi_bleu",limit=1] at @s run data modify block ^ ^1 ^1 {} merge value {front_text:{messages:['[""]','["",{text:"DEVENIR",bold:true,color:dark_blue}]','[{text:"LE ROI",bold:true,color:dark_blue,click_event:{action:run_command,command:"trigger sgp.devenir_roi_bleu"}}]','[""]']}}


function sgp.majeurs:protect/dispatch

function sgp.mineurs:_stop

scoreboard players set #mort_roi_rouge_annoncee sgp.dummy 0
scoreboard players set #mort_roi_bleue_annoncee sgp.dummy 0

execute at @e[type=marker,tag=sgp.marker,name="devenir_roi_rouge",limit=1] as @a[distance=..2,tag=sgp.major_participant] run scoreboard players enable @s sgp.devenir_roi_rouge
execute at @e[type=marker,tag=sgp.marker,name="devenir_roi_rouge",limit=1] as @a[distance=..2,tag=sgp.major_participant] run title @s title [{text:"Équipe Rouge", color:dark_red}]

execute at @e[type=marker,tag=sgp.marker,name="devenir_roi_bleu",limit=1] as @a[distance=..2,tag=sgp.major_participant] run scoreboard players enable @s sgp.devenir_roi_bleu
execute at @e[type=marker,tag=sgp.marker,name="devenir_roi_bleu",limit=1] as @a[distance=..2,tag=sgp.major_participant] run title @s title [{text:"Équipe Bleue", color:dark_blue}]

execute at @e[type=marker,tag=sgp.marker,name="devenir_roi_bleu",limit=1] as @a[distance=..2,tag=sgp.major_participant] run move @s #Bleus
execute at @e[type=marker,tag=sgp.marker,name="devenir_roi_rouge",limit=1] as @a[distance=..2,tag=sgp.major_participant] run move @s #Rouges
