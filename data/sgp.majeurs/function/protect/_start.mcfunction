#> sgp.majeurs:protect/_start
#
# Start a Protéger le Roi round in its king-selection phase.

execute if entity @a[predicate=sgp.majeurs:event_in_progress] run return 0

tellraw @a[tag=sgp.in_game] [{text:"Lancement de l'événement Protéger le Roi...",color:gold,bold:true}]
function sgp.majeurs:common/start

scoreboard players set #protect_phase sgp.dummy 1

function sgp.majeurs:protect/dispatch

execute as @e[tag=sgp.marker,name="devenir_roi_rouge",limit=1,type=marker] at @s run function sgp.majeurs:protect/setup_king_selector {side:rouge,team:rouge,name:Rouge,color:dark_red}
execute as @e[tag=sgp.marker,name="devenir_roi_bleu",limit=1,type=marker] at @s run function sgp.majeurs:protect/setup_king_selector {side:bleu,team:bleue,name:Bleu,color:dark_blue}

title @a[team=sgp.rouge] title {text:"Équipe Rouge",color:dark_red}
title @a[team=sgp.bleue] title {text:"Équipe Bleue",color:dark_blue}
move @a[team=sgp.rouge] #Rouges
move @a[team=sgp.bleue] #Bleus
