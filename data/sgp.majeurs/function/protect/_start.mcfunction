execute run tellraw @a[tag=sgp.in_game] [{"text":"Lancement de l'event Proteger le Roi...", "color":"gold", "bold":true}]
execute as @a[tag=sgp.in_game] run function sgp.misc:on_death
execute as @n[type=marker,tag=sgp.marker,name="devenir_roi_rouge"] at @s run data modify block ^ ^1 ^1 {} merge value {front_text:{messages:['[""]','["",{"text":"DEVENIR","bold":true,"color":"dark_red"}]','[{"text":"LE ROI","bold":true,"color":"dark_red","clickEvent":{"action":"run_command","value":"trigger sgp.devenir_roi_rouge"}}]','[""]']}}
execute as @n[type=marker,tag=sgp.marker,name="devenir_roi_bleu"] at @s run data modify block ^ ^1 ^1 {} merge value {front_text:{messages:['[""]','["",{"text":"DEVENIR","bold":true,"color":"dark_blue"}]','[{"text":"LE ROI","bold":true,"color":"dark_blue","clickEvent":{"action":"run_command","value":"trigger sgp.devenir_roi_bleu"}}]','[""]']}}
execute run function sgp.majeurs:protect/dispatch
function sgp.mineurs:_stop
scoreboard players set #mort_roi_rouge_annoncee sgp.dummy 0
scoreboard players set #mort_roi_bleu_annoncee sgp.dummy 0
execute at @n[type=marker,tag=sgp.marker,name="devenir_roi_rouge"] as @a[distance=..2] run scoreboard players enable @s sgp.devenir_roi_rouge
execute at @n[type=marker,tag=sgp.marker,name="devenir_roi_rouge"] as @a[distance=..2] run title @s title [{"text":"Équipe Rouge", "color":"dark_red"}]
execute at @n[type=marker,tag=sgp.marker,name="devenir_roi_bleu"] as @a[distance=..2] run scoreboard players enable @s sgp.devenir_roi_bleu
execute at @n[type=marker,tag=sgp.marker,name="devenir_roi_bleu"] as @a[distance=..2] run title @s title [{"text":"Équipe Bleue", "color":"dark_blue"}]
statuswarp pvp disabled
execute at @n[type=marker,tag=sgp.marker,name="devenir_roi_bleu"] as @a[distance=..2] run move @s #Bleus
execute at @n[type=marker,tag=sgp.marker,name="devenir_roi_rouge"] as @a[distance=..2] run move @s #Rouges
useglow toggle
function sgp.lore:npcs/disable