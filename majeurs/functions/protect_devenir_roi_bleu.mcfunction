execute as @p[scores={devenirroibleu=1..}] run function kits:roi
effect give @p[scores={devenirroibleu=1..}] minecraft:health_boost infinite 4 true
effect give @p[scores={devenirroibleu=1..}] minecraft:regeneration 2 10 true
tag @p[scores={devenirroibleu=1..}] add roibleu
team join bleue @a[x=2410,y=251,z=2161,dx=3,dy=3,dz=3]
execute as @p[scores={devenirroibleu=1..}] run item replace entity @s hotbar.2 with minecraft:golden_apple{display:{Name:'{"text":"Pomme d\'or","color":"yellow","italic":false,"bold":true}', Lore:['[{"text":"Régénère jusqu\'à 6","color":"gray","italic":false},{"text":"❤","color":"red","italic":false},{"text":" + 2","color":"gray","italic":false},{"text":"❤","color":"yellow","italic":false}]']}} 12
tp @p[scores={devenirroibleu=1..}] 2523.5 231 2160 90 0
scoreboard players set @a[x=2410,y=251,z=2161,dx=3,dy=3,dz=3] entre_kits 1
scoreboard players set @p[scores={devenirroibleu=1..}] devenirroibleu 0
execute as @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72] run trigger devenirroibleu set 0
tellraw @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72] ["",{"selector":"@a[tag=roibleu]","color":"dark_blue","bold":true},{"text":" est le roi ","color":"gold"},{"text":"Bleu","color":"dark_blue","bold":true}]
