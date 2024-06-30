execute as @p[scores={sgp.devenir_roi_rouge=1..}] run function sgp.kits:collection/roi
effect give @p[scores={sgp.devenir_roi_rouge=1..}] minecraft:health_boost infinite 4 true
effect give @p[scores={sgp.devenir_roi_rouge=1..}] minecraft:regeneration 2 10 true
tag @p[scores={sgp.devenir_roi_rouge=1..}] add sgp.roi_rouge
execute at @e[type=marker,tag=sgp.marker,name="devenir_roi_rouge",limit=1] as @a[distance=..2] run team join sgp.rouge @s
execute as @p[scores={sgp.devenir_roi_rouge=1..}] run item replace entity @s hotbar.2 with minecraft:golden_apple{display:{Name:'{"text":"Pomme d\'or","color":"yellow","italic":false,"bold":true}', Lore:['[{"text":"Régénère jusqu\'à 6","color":"gray","italic":false},{"text":"❤","color":"red","italic":false},{"text":" + 2","color":"gray","italic":false},{"text":"❤","color":"yellow","italic":false}]']}} 12
tp @p[scores={sgp.devenir_roi_rouge=1..}] @e[type=marker,tag=sgp.marker,name="protect_spawn_rouges",limit=1]
execute at @e[type=marker,tag=sgp.marker,name="devenir_roi_rouge",limit=1] as @a[distance=..2] run scoreboard players set @s sgp.entre_kits 1
scoreboard players set @p[scores={sgp.devenir_roi_rouge=1..}] sgp.devenir_roi_rouge 0
execute as @a[tag=in_game] run trigger sgp.devenir_roi_rouge set 0
tellraw @a[tag=in_game] ["",{"selector":"@a[tag=sgp.roi_rouge]","color":"dark_red","bold":true},{"text":" est le roi ","color":"gold"},{"text":"Rouge","color":"dark_red","bold":true}]