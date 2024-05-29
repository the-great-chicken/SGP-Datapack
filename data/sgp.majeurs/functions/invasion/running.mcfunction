#> sgp.majeurs:invasion/running
# 
# Executed each tick when the major event Invasion is running
#
# Deals damage each second to Defenders below their area
#
# Also runs the timer, as the event has a time limit

scoreboard players add #invasion_ticks sgp.timer 1
execute if score #invasion_ticks sgp.timer matches 20 run scoreboard players add #invasion_secondes sgp.timer 1
execute if score #invasion_ticks sgp.timer matches 20 run scoreboard players set #invasion_ticks sgp.timer 0

execute if score #invasion_ticks sgp.timer matches 0 run execute as @a[team=sgp.Defenseur] at @s if entity @s[y=200,dy=49] run damage @s 6 minecraft:starve
execute if score #invasion_ticks sgp.timer matches 0 run experience add @a[tag=in_game] -1 levels

# Timer Écoulé
execute if score #invasion_secondes sgp.timer >= #invasion_joueurs sgp.dummy run tellraw @a[tag=in_game] [{"text":"Les Défenseurs ont gagné ! Ils ont survécu suffisament longtemps","color":"blue","bold":true}]
execute if score #invasion_secondes sgp.timer >= #invasion_joueurs sgp.dummy run title @a[tag=in_game] title [{"text":"Défenseurs Vainqueurs","color":"blue","bold":true}]
execute if score #invasion_secondes sgp.timer >= #invasion_joueurs sgp.dummy run function sgp.majeurs:invasion/_stop

# Prévenir qu'il reste peu de temps
execute if score #invasion_ticks sgp.timer matches 0 run scoreboard players operation #invasion-100 sgp.timer = #invasion_joueurs sgp.dummy
execute if score #invasion_ticks sgp.timer matches 0 run scoreboard players operation #invasion-100 sgp.timer -= #invasion_secondes sgp.timer
execute if score #invasion_ticks sgp.timer matches 0 run execute if score #invasion-100 sgp.timer matches 60 run tellraw @a[tag=in_game] [{"text":"Il reste 1 minute avant que les Défenseurs gagnent !","bold":true,"color":"blue"}]
execute if score #invasion_ticks sgp.timer matches 0 run execute if score invasion-100 sgp.timer matches 60 run playsound minecraft:entity.experience_orb.pickup ambient @a[tag=in_game] 2429.70 254.00 2132.25 1000 0.5