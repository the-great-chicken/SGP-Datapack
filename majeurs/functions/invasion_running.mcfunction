scoreboard players add #invasion_ticks timer 1
execute if score #invasion_ticks timer matches 20 run scoreboard players add #invasion_secondes timer 1
execute if score #invasion_ticks timer matches 20 run scoreboard players set #invasion_ticks timer 0

execute if score #invasion_ticks timer matches 0 run execute as @a[team=Defenseur] at @s if entity @s[y=200,dy=49] run damage @s 6 minecraft:starve
execute if score #invasion_ticks timer matches 0 run experience add @a[x=2405,y=201,z=2133,dx=137,dy=57,dz=72] -1 levels

# Timer Écoulé
execute if score #invasion_secondes timer >= #invasion_joueurs dummy run tellraw @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72] [{"text":"Les Défenseurs ont gagné ! Ils ont survécu suffisament longtemps","color":"blue","bold":true}]
execute if score #invasion_secondes timer >= #invasion_joueurs dummy run title @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72] title [{"text":"Défenseurs Vainqueurs","color":"blue","bold":true}]
execute if score #invasion_secondes timer >= #invasion_joueurs dummy run function majeurs:invasion_stop

# Prévenir qu'il reste peu de temps
execute if score #invasion_ticks timer matches 0 run scoreboard players operation #invasion-100 timer = #invasion_joueurs dummy
execute if score #invasion_ticks timer matches 0 run scoreboard players operation #invasion-100 timer -= #invasion_secondes timer
execute if score #invasion_ticks timer matches 0 run execute if score #invasion-100 timer matches 60 run tellraw @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72] [{"text":"Il reste 1 minute avant que les Défenseurs gagnent !","bold":true,"color":"blue"}]
execute if score #invasion_ticks timer matches 0 run execute if score invasion-100 timer matches 60 run playsound minecraft:entity.experience_orb.pickup ambient @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72] 2429.70 254.00 2132.25 1000 0.5