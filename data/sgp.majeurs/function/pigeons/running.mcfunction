# Kill d'un chasseur
execute as @a[tag=!pigeon] if score @s sgp.death_reset_tags matches 1 run scoreboard players add #chasseurs_tues sgp.dummy 1
execute as @a[tag=!pigeon] if score @s sgp.death_reset_tags matches 1 run function sgp.majeurs:pigeons/on_death
execute as @a[tag=!pigeon] if score @s sgp.death_reset_tags matches 1 run scoreboard players set @s sgp.death_reset_tags 0

# Kill d'un pigeon
execute as @a[tag=pigeon] if score @s sgp.death_reset_tags matches 1 run tag @s add loser
execute as @a[tag=loser] run scoreboard players set @s sgp.death_reset_tags 0
execute as @a[tag=loser] run tag @s remove pigeon
move @a[tag=loser] #Chasseurs
execute as @a[tag=loser] run function sgp.majeurs:pigeons/on_death
execute as @a[tag=loser] run tag @s remove loser

# Tous les pigeons sont morts
execute unless entity @a[tag=pigeon] run tellraw @a[tag=in_game] [{"text":"Les Chasseurs ont gagné !","color":"green","bold":true}]
execute unless entity @a[tag=pigeon] run function sgp.majeurs:pigeons/_stop
execute unless entity @a[tag=pigeon] run title @a[tag=in_game] title [{"text":"Chasseurs Vainqueurs","bold":true,"color":"green"}]