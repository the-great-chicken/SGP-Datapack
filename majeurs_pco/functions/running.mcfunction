# Activer/désactiver le fait de pouvoir cliquer sur les panneaux de libération
execute as @a[team=Oie,distance=..6.5,x=2529.5,y=248,z=2142.5,scores={liberer_oies=0}] unless entity @s[x=2527.5,y=248,z=2141.3,dx=3,dy=2,dz=2.2] run scoreboard players enable @s liberer_oies
execute as @a[team=Oie,distance=..6.5,x=2529.5,y=248,z=2142.5,scores={liberer_oies=0}] unless entity @s[x=2527.5,y=248,z=2141.3,dx=3,dy=2,dz=2.2] run scoreboard players set @s liberer_oies 1
execute as @a[team=Oie,distance=6.5..,x=2529.5,y=248,z=2142.5,scores={liberer_oies=1}] run trigger liberer_oies set 0
execute as @a[team=Oie,x=2527.5,y=248,z=2141.3,dx=3,dy=2,dz=2.2,scores={liberer_oies=1}] run trigger liberer_oies set 0

execute as @a[team=Canard,distance=..8.5,x=2481.5,y=244,z=2137.5,scores={liberer_canards=0}] unless entity @s[x=2478.5,y=244,z=2138.3,dx=5,dy=2,dz=1.2] run scoreboard players enable @s liberer_canards
execute as @a[team=Canard,distance=..8.5,x=2481.5,y=244,z=2137.5,scores={liberer_canards=0}] unless entity @s[x=2478.5,y=244,z=2138.3,dx=5,dy=2,dz=1.2] run scoreboard players set @s liberer_canards 1
execute as @a[team=Canard,distance=8.5..,x=2481.5,y=244,z=2137.5,scores={liberer_canards=1}] run trigger liberer_canards set 0
execute as @a[team=Canard,x=2478.5,y=244,z=2138.3,dx=5,dy=2,dz=1.2,scores={liberer_canards=1}] run trigger liberer_canards set 0

execute as @a[team=Poule,distance=..8,x=2497.5,y=239,z=2186.5,scores={liberer_poules=0}] unless entity @s[x=2496.5,y=239,z=2183.5,dx=3,dy=2,dz=3] run scoreboard players enable @s liberer_poules
execute as @a[team=Poule,distance=..8,x=2497.5,y=239,z=2186.5,scores={liberer_poules=0}] unless entity @s[x=2496.5,y=239,z=2183.5,dx=3,dy=2,dz=3] run scoreboard players set @s liberer_poules 1
execute as @a[team=Poule,distance=8..,x=2497.5,y=239,z=2186.5,scores={liberer_poules=1}] run trigger liberer_poules set 0
execute as @a[team=Poule,x=2496.5,z=2183.5,y=239,dx=3,dy=2,dz=3,scores={liberer_poules=1}] run trigger liberer_poules set 0


# Si on clique sur un panneau de libération
execute as @a[scores={liberer_oies=2}] run function majeurs_pco:liberer_oies
execute as @a[scores={liberer_oies=2}] run scoreboard players set @a liberer_oies 0
execute as @a[scores={liberer_poules=2}] run function majeurs_pco:liberer_poules
execute as @a[scores={liberer_poules=2}] run scoreboard players set @a liberer_poules 0
execute as @a[scores={liberer_canards=2}] run function majeurs_pco:liberer_canards
execute as @a[scores={liberer_canards=2}] run scoreboard players set @a liberer_canards 0


# Check si des joueurs sont en cage, et si tous les joueurs d'une équipe le sont, la partie se termine
execute as @a[team=Poule] at @s if entity @s[x=2496.5,y=239,z=2183.5,dx=3,dy=2,dz=3] run scoreboard players set @s en_cage 1
execute as @a[team=Poule,scores={en_cage=1}] at @s unless entity @s[x=2496.5,y=239,z=2183.5,dx=3,dy=2,dz=3] run scoreboard players set @s en_cage 0
execute as @a[team=Poule] run scoreboard players add #poules nbr_de_joueurs 1
execute as @a[team=Poule,scores={en_cage=1}] run scoreboard players add #poules en_cage 1
execute if score #poules en_cage = #poules nbr_de_joueurs run function majeurs_pco:stop
execute if score #poules en_cage = #poules nbr_de_joueurs run title @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72] title {"text":"Oies Victorieuses","color":"yellow","bold":true}
scoreboard players set #poules nbr_de_joueurs 0
scoreboard players set #poules en_cage 0

execute as @a[team=Canard] at @s if entity @s[x=2478.5,y=244,z=2138.3,dx=5,dy=2,dz=1.2] run scoreboard players set @s en_cage 1
execute as @a[team=Canard,scores={en_cage=1}] at @s unless entity @s[x=2478.5,y=244,z=2138.3,dx=5,dy=2,dz=1.2] run scoreboard players set @s en_cage 0
execute as @a[team=Canard] run scoreboard players add #canards nbr_de_joueurs 1
execute as @a[team=Canard,scores={en_cage=1}] run scoreboard players add #canards en_cage 1
execute if score #canards en_cage = #canards nbr_de_joueurs run function majeurs_pco:stop
execute if score #canards en_cage = #canards nbr_de_joueurs run title @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72] title {"text":"Poules Victorieuses","color":"red","bold":true}
scoreboard players set #canards nbr_de_joueurs 0
scoreboard players set #canards en_cage 0

execute as @a[team=Oie] at @s if entity @s[x=2527.5,y=248,z=2141.3,dx=3,dy=2,dz=2.2] run scoreboard players set @s en_cage 1
execute as @a[team=Oie,scores={en_cage=1}] at @s unless entity @s[x=2527.5,y=248,z=2141.3,dx=3,dy=2,dz=2.2] run scoreboard players set @s en_cage 0
execute as @a[team=Oie] run scoreboard players add #oies nbr_de_joueurs 1
execute as @a[team=Oie,scores={en_cage=1}] run scoreboard players add #oies en_cage 1
execute if score #oies en_cage = #oies nbr_de_joueurs run function majeurs_pco:stop
execute if score #oies en_cage = #oies nbr_de_joueurs run title @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72] title {"text":"Canards Victorieux","color":"green","bold":true}
scoreboard players set #oies nbr_de_joueurs 0
scoreboard players set #oies en_cage 0
