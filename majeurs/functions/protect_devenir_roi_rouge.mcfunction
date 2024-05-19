execute as @p[scores={devenirroirouge=1..}] run function kits:roi
effect give @p[scores={devenirroirouge=1..}] minecraft:health_boost infinite 4 true
effect give @p[scores={devenirroirouge=1..}] minecraft:regeneration 2 10 true
tag @p[scores={devenirroirouge=1..}] add roirouge
team join rouge @a[x=2414,y=251,z=2161,dx=3,dy=3,dz=3]
execute as @p[scores={devenirroirouge=1..}] run item replace entity @s hotbar.2 with minecraft:golden_apple{display:{Name:'{"text":"Pomme d\'or","color":"yellow","italic":false,"bold":true}', Lore:['[{"text":"Régénère jusqu\'à 6","color":"gray","italic":false},{"text":"❤","color":"red","italic":false},{"text":" + 2","color":"gray","italic":false},{"text":"❤","color":"yellow","italic":false}]']}} 12
tp @p[scores={devenirroirouge=1..}] 2429.5 229 2172.0 270 0
scoreboard players set @a[x=2414,y=251,z=2161,dx=3,dy=3,dz=3] entre_kits 1
setblock 2412 251 2171 minecraft:redstone_block
setblock 2412 251 2170 minecraft:redstone_block
scoreboard players set @p[scores={devenirroirouge=1..}] devenirroirouge 0
execute as @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72] run trigger devenirroirouge set 0
tellraw @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72] ["",{"selector":"@a[tag=roirouge]","color":"dark_red","bold":true},{"text":" est le roi ","color":"gold"},{"text":"Rouge","color":"dark_red","bold":true}]