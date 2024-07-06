execute as @a[tag=sgp.in_game] run scoreboard players operation @s sgp.temps_cabane_pco_secondes = @s sgp.temps_cabane_pco
execute as @a[tag=sgp.in_game] run scoreboard players operation @s sgp.temps_cabane_pco_secondes /= 100 sgp.dummy
execute as @a[tag=sgp.in_game] run function sgp.majeurs:pco/dans_cabane_actionbar

execute as @a[team=sgp.Poule] at @s if entity @s[x=2478.900,y=244,z=2140.900,dx=4.0,dy=2,dz=2.3] run scoreboard players remove @s sgp.temps_cabane_pco 5
execute as @a[team=sgp.Poule] at @s if entity @s[x=2479,y=244,z=2141,dx=4,dy=2,dz=1] if score @s sgp.temps_cabane_pco matches 1.. run effect give @s minecraft:resistance 2 5 false
execute as @a[team=sgp.Poule] at @s if entity @s[x=2479,y=244,z=2141,dx=4,dy=2,dz=1] if score @s sgp.temps_cabane_pco matches ..0 run effect give @s minecraft:wither 1 1 false

execute as @a[team=sgp.Oie] at @s if entity @s[x=2497,y=239,z=2180,dx=2,dy=2,dz=2] run scoreboard players remove @s sgp.temps_cabane_pco 5
execute as @a[team=sgp.Oie] at @s if entity @s[x=2497,y=239,z=2180,dx=2,dy=2,dz=2] if score @s sgp.temps_cabane_pco matches 1.. run effect give @s minecraft:resistance 2 5 false
execute as @a[team=sgp.Oie] at @s if entity @s[x=2497,y=239,z=2180,dx=2,dy=2,dz=2] if score @s sgp.temps_cabane_pco matches ..0 run effect give @s minecraft:wither 1 1 false

execute as @a[team=sgp.Canard] at @s if entity @s[x=2524,y=248,z=2141,dx=2,dy=2,dz=2] run scoreboard players remove @s sgp.temps_cabane_pco 5
execute as @a[team=sgp.Canard] at @s if entity @s[x=2524,y=248,z=2141,dx=2,dy=2,dz=2] if score @s sgp.temps_cabane_pco matches 1.. run effect give @s minecraft:resistance 2 5 false
execute as @a[team=sgp.Canard] at @s if entity @s[x=2524,y=248,z=2141,dx=2,dy=2,dz=2] if score @s sgp.temps_cabane_pco matches ..0 run effect give @s minecraft:wither 1 1 false

execute as @a[team=sgp.Canard] at @s if entity @s[x=2538,y=248,z=2141,dx=2,dy=2,dz=2] run scoreboard players remove @s sgp.temps_cabane_pco 5
execute as @a[team=sgp.Canard] at @s if entity @s[x=2538,y=248,z=2141,dx=2,dy=2,dz=2] if score @s sgp.temps_cabane_pco matches 1.. run effect give @s minecraft:resistance 2 5 false
execute as @a[team=sgp.Canard] at @s if entity @s[x=2538,y=248,z=2141,dx=2,dy=2,dz=2] if score @s sgp.temps_cabane_pco matches ..0 run effect give @s minecraft:wither 1 1 false