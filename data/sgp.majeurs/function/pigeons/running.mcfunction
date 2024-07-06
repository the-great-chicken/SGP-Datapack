# Kill d'un chasseur
execute as @a[tag=!sgp.pigeon] if score @s sgp.death_reset_tags matches 1 run scoreboard players add #chasseurs_tues sgp.dummy 1
execute as @a[tag=!sgp.pigeon] if score @s sgp.death_reset_tags matches 1 run function sgp.majeurs:pigeons/on_death
execute as @a[tag=!sgp.pigeon] if score @s sgp.death_reset_tags matches 1 run scoreboard players set @s sgp.death_reset_tags 0

# Kill d'un pigeon
execute as @a[tag=sgp.pigeon] if score @s sgp.death_reset_tags matches 1 run tag @s add sgp.loser
execute as @a[tag=sgp.loser] run scoreboard players set @s sgp.death_reset_tags 0
execute as @a[tag=sgp.loser] run tag @s remove sgp.pigeon
move @a[tag=sgp.loser] #Chasseurs
execute as @a[tag=sgp.loser] run function sgp.majeurs:pigeons/on_death
execute as @a[tag=sgp.loser] run tag @s remove sgp.loser

# Tous les pigeons sont morts
execute unless entity @a[tag=sgp.pigeon] run tellraw @a[tag=sgp.in_game] [{"text":"Les Chasseurs ont gagné !","color":"green","bold":true}]
execute unless entity @a[tag=sgp.pigeon] run function sgp.majeurs:pigeons/_stop
execute unless entity @a[tag=sgp.pigeon] run title @a[tag=sgp.in_game] title [{"text":"Chasseurs Vainqueurs","bold":true,"color":"green"}]