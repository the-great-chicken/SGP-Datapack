execute as @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72] run scoreboard players operation @s temps_cabane_pco_secondes = @s temps_cabane_pco
execute as @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72] run scoreboard players operation @s temps_cabane_pco_secondes /= 100 dummy
execute as @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72] run title @s actionbar ["",{"text":"Temps autorisé dans le refuge : "},{"score":{"name":"@s","objective":"temps_cabane_pco_secondes"},"bold":true,"color":"red"}]

execute as @a[team=Poule] at @s if entity @s[x=2478.900,y=244,z=2140.900,dx=4.0,dy=2,dz=2.3] run scoreboard players remove @s temps_cabane_pco 5
execute as @a[team=Poule] at @s if entity @s[x=2479,y=244,z=2141,dx=4,dy=2,dz=1] if score @s temps_cabane_pco > 0 dummy run effect give @s minecraft:resistance 2 5 false
execute as @a[team=Poule] at @s if entity @s[x=2479,y=244,z=2141,dx=4,dy=2,dz=1] if score @s temps_cabane_pco <= 0 dummy run effect give @s minecraft:wither 1 1 false

execute as @a[team=Oie] at @s if entity @s[x=2497,y=239,z=2180,dx=2,dy=2,dz=2] run scoreboard players remove @s temps_cabane_pco 5
execute as @a[team=Oie] at @s if entity @s[x=2497,y=239,z=2180,dx=2,dy=2,dz=2] if score @s temps_cabane_pco > 0 dummy run effect give @s minecraft:resistance 2 5 false
execute as @a[team=Oie] at @s if entity @s[x=2497,y=239,z=2180,dx=2,dy=2,dz=2] if score @s temps_cabane_pco <= 0 dummy run effect give @s minecraft:wither 1 1 false

execute as @a[team=Canard] at @s if entity @s[x=2524,y=248,z=2141,dx=2,dy=2,dz=2] run scoreboard players remove @s temps_cabane_pco 5
execute as @a[team=Canard] at @s if entity @s[x=2524,y=248,z=2141,dx=2,dy=2,dz=2] if score @s temps_cabane_pco > 0 dummy run effect give @s minecraft:resistance 2 5 false
execute as @a[team=Canard] at @s if entity @s[x=2524,y=248,z=2141,dx=2,dy=2,dz=2] if score @s temps_cabane_pco <= 0 dummy run effect give @s minecraft:wither 1 1 false

execute as @a[team=Canard] at @s if entity @s[x=2538,y=248,z=2141,dx=2,dy=2,dz=2] run scoreboard players remove @s temps_cabane_pco 5
execute as @a[team=Canard] at @s if entity @s[x=2538,y=248,z=2141,dx=2,dy=2,dz=2] if score @s temps_cabane_pco > 0 dummy run effect give @s minecraft:resistance 2 5 false
execute as @a[team=Canard] at @s if entity @s[x=2538,y=248,z=2141,dx=2,dy=2,dz=2] if score @s temps_cabane_pco <= 0 dummy run effect give @s minecraft:wither 1 1 false