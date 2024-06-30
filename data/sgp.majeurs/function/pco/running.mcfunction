# Activer/désactiver le fait de pouvoir cliquer sur les panneaux de libération
execute as @a[team=sgp.Oie,distance=..6.5,x=2529.5,y=248,z=2142.5,scores={sgp.liberer_oies=0}] unless entity @s[x=2527.5,y=248,z=2141.3,dx=3,dy=2,dz=2.2] run scoreboard players enable @s sgp.liberer_oies
execute as @a[team=sgp.Oie,distance=..6.5,x=2529.5,y=248,z=2142.5,scores={sgp.liberer_oies=0}] unless entity @s[x=2527.5,y=248,z=2141.3,dx=3,dy=2,dz=2.2] run scoreboard players set @s sgp.liberer_oies 1
execute as @a[team=sgp.Oie,distance=6.5..,x=2529.5,y=248,z=2142.5,scores={sgp.liberer_oies=1}] run trigger sgp.liberer_oies set 0
execute as @a[team=sgp.Oie,x=2527.5,y=248,z=2141.3,dx=3,dy=2,dz=2.2,scores={sgp.liberer_oies=1}] run trigger sgp.liberer_oies set 0

execute as @a[team=sgp.Canard,distance=..8.5,x=2481.5,y=244,z=2137.5,scores={sgp.liberer_canards=0}] unless entity @s[x=2478.5,y=244,z=2138.3,dx=5,dy=2,dz=1.2] run scoreboard players enable @s sgp.liberer_canards
execute as @a[team=sgp.Canard,distance=..8.5,x=2481.5,y=244,z=2137.5,scores={sgp.liberer_canards=0}] unless entity @s[x=2478.5,y=244,z=2138.3,dx=5,dy=2,dz=1.2] run scoreboard players set @s sgp.liberer_canards 1
execute as @a[team=sgp.Canard,distance=8.5..,x=2481.5,y=244,z=2137.5,scores={sgp.liberer_canards=1}] run trigger sgp.liberer_canards set 0
execute as @a[team=sgp.Canard,x=2478.5,y=244,z=2138.3,dx=5,dy=2,dz=1.2,scores={sgp.liberer_canards=1}] run trigger sgp.liberer_canards set 0

execute as @a[team=sgp.Poule,distance=..8,x=2497.5,y=239,z=2186.5,scores={sgp.liberer_poules=0}] unless entity @s[x=2496.5,y=239,z=2183.5,dx=3,dy=2,dz=3] run scoreboard players enable @s sgp.liberer_poules
execute as @a[team=sgp.Poule,distance=..8,x=2497.5,y=239,z=2186.5,scores={sgp.liberer_poules=0}] unless entity @s[x=2496.5,y=239,z=2183.5,dx=3,dy=2,dz=3] run scoreboard players set @s sgp.liberer_poules 1
execute as @a[team=sgp.Poule,distance=8..,x=2497.5,y=239,z=2186.5,scores={sgp.liberer_poules=1}] run trigger sgp.liberer_poules set 0
execute as @a[team=sgp.Poule,x=2496.5,z=2183.5,y=239,dx=3,dy=2,dz=3,scores={sgp.liberer_poules=1}] run trigger sgp.liberer_poules set 0


# Si on clique sur un panneau de libération
execute as @a[scores={sgp.liberer_oies=2}] run function sgp.majeurs:pco/oie/liberer
execute as @a[scores={sgp.liberer_oies=2}] run scoreboard players set @a[tag=in_game] sgp.liberer_oies 0
execute as @a[scores={sgp.liberer_poules=2}] run function sgp.majeurs:pco/poule/liberer
execute as @a[scores={sgp.liberer_poules=2}] run scoreboard players set @a[tag=in_game] sgp.liberer_poules 0
execute as @a[scores={sgp.liberer_canards=2}] run function sgp.majeurs:pco/canard/liberer
execute as @a[scores={sgp.liberer_canards=2}] run scoreboard players set @a[tag=in_game] sgp.liberer_canards 0


# Check si des joueurs sont en cage, et si tous les joueurs d'une équipe le sont, la partie se termine
execute as @a[team=sgp.Poule] at @s if entity @s[x=2496.5,y=239,z=2183.5,dx=3,dy=2,dz=3] run scoreboard players set @s sgp.en_cage 1
execute as @a[team=sgp.Poule,scores={sgp.en_cage=1}] at @s unless entity @s[x=2496.5,y=239,z=2183.5,dx=3,dy=2,dz=3] run scoreboard players set @s sgp.en_cage 0
execute as @a[team=sgp.Poule] run scoreboard players add #poules_joueurs sgp.dummy 1
execute as @a[team=sgp.Poule,scores={sgp.en_cage=1}] run scoreboard players add #poules sgp.en_cage 1
execute if score #poules sgp.en_cage = #poules_joueurs sgp.dummy run function sgp.majeurs:pco/_stop
execute if score #poules sgp.en_cage = #poules_joueurs sgp.dummy run title @a[tag=in_game] title {"text":"Oies Victorieuses","color":"yellow","bold":true}
scoreboard players set #poules_joueurs sgp.dummy 0
scoreboard players set #poules sgp.en_cage 0

execute as @a[team=sgp.Canard] at @s if entity @s[x=2478.5,y=244,z=2138.3,dx=5,dy=2,dz=1.2] run scoreboard players set @s sgp.en_cage 1
execute as @a[team=sgp.Canard,scores={sgp.en_cage=1}] at @s unless entity @s[x=2478.5,y=244,z=2138.3,dx=5,dy=2,dz=1.2] run scoreboard players set @s sgp.en_cage 0
execute as @a[team=sgp.Canard] run scoreboard players add #canards_joueurs sgp.dummy 1
execute as @a[team=sgp.Canard,scores={sgp.en_cage=1}] run scoreboard players add #canards sgp.en_cage 1
execute if score #canards sgp.en_cage = #canards_joueurs sgp.dummy run function sgp.majeurs:pco/_stop
execute if score #canards sgp.en_cage = #canards_joueurs sgp.dummy run title @a[tag=in_game] title {"text":"Poules Victorieuses","color":"red","bold":true}
scoreboard players set #canards_joueurs sgp.dummy 0
scoreboard players set #canards sgp.en_cage 0

execute as @a[team=sgp.Oie] at @s if entity @s[x=2527.5,y=248,z=2141.3,dx=3,dy=2,dz=2.2] run scoreboard players set @s sgp.en_cage 1
execute as @a[team=sgp.Oie,scores={sgp.en_cage=1}] at @s unless entity @s[x=2527.5,y=248,z=2141.3,dx=3,dy=2,dz=2.2] run scoreboard players set @s sgp.en_cage 0
execute as @a[team=sgp.Oie] run scoreboard players add #oies_joueurs sgp.dummy 1
execute as @a[team=sgp.Oie,scores={sgp.en_cage=1}] run scoreboard players add #oies sgp.en_cage 1
execute if score #oies sgp.en_cage = #oies_joueurs sgp.dummy run function sgp.majeurs:pco/_stop
execute if score #oies sgp.en_cage = #oies_joueurs sgp.dummy run title @a[tag=in_game] title {"text":"Canards Victorieux","color":"green","bold":true}
scoreboard players set #oies_joueurs sgp.dummy 0
scoreboard players set #oies sgp.en_cage 0
