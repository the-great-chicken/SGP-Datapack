execute as @p[scores={devenir_roi_bleu=1..}] run function kits:roi
effect give @p[scores={devenir_roi_bleu=1..}] minecraft:health_boost infinite 4 true
effect give @p[scores={devenir_roi_bleu=1..}] minecraft:regeneration 2 10 true
tag @p[scores={devenir_roi_bleu=1..}] add roi_bleu
execute at @e[type=marker,name="devenir_roi_bleu",limit=1] as @a[distance=..2] run team join bleue @s
execute as @p[scores={devenir_roi_bleu=1..}] run item replace entity @s hotbar.2 with minecraft:golden_apple{display:{Name:'{"text":"Pomme d\'or","color":"yellow","italic":false,"bold":true}', Lore:['[{"text":"Régénère jusqu\'à 6","color":"gray","italic":false},{"text":"❤","color":"red","italic":false},{"text":" + 2","color":"gray","italic":false},{"text":"❤","color":"yellow","italic":false}]']}} 12
tp @p[scores={devenir_roi_bleu=1..}] 2523.5 231 2160 90 0
execute at @e[type=marker,name="devenir_roi_bleu",limit=1] as @a[distance=..2] run scoreboard players set @s entre_kits 1
scoreboard players set @p[scores={devenir_roi_bleu=1..}] devenir_roi_bleu 0
execute as @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72] run trigger devenir_roi_bleu set 0
tellraw @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72] ["",{"selector":"@a[tag=roi_bleu]","color":"dark_blue","bold":true},{"text":" est le roi ","color":"gold"},{"text":"Bleu","color":"dark_blue","bold":true}]
