scoreboard players add #pigeons_ticks sgp.timer 1

# Passage à la seconde
execute if score #pigeons_ticks sgp.timer matches 20 run scoreboard players add #pigeons_secondes sgp.timer 1
execute if score #pigeons_ticks sgp.timer matches 20 run scoreboard players set #pigeons_ticks sgp.timer 0

# Passage à la minute
execute if score #pigeons_secondes sgp.timer matches 60 run scoreboard players add #pigeons_minutes sgp.timer 1
execute if score #pigeons_secondes sgp.timer matches 60 run tellraw @a [{"text":"Il reste ","bold":true,"color":"blue"},{"score":{"name":"#invasion_minutes","objective":"sgp.timer"},"color":"gold"}," minute(s) !"]
execute if score #pigeons_secondes sgp.timer matches 60 run scoreboard players set #pigeons_secondes sgp.timer 0

# ------ Après 10 minutes ------
# Si suffisament de kills de chasseurs
execute if score #pigeons_minutes sgp.timer matches 10 if score #chasseurs_tues sgp.dummy >= #pigeons_joueurs sgp.dummy run tellraw @a [{"text":"Les Pigeons ont gagné !","color":"gray","bold":true}]
execute if score #pigeons_minutes sgp.timer matches 10 if score #chasseurs_tues sgp.dummy >= #pigeons_joueurs sgp.dummy run title @a title [{"text":"Les Pigeons ont gagné !","bold":true,"color":"gray"}]

# Si insuffisament de kills de chasseurs
execute if score #pigeons_minutes sgp.timer matches 10 if score #chasseurs_tues sgp.dummy < #pigeons_joueurs sgp.dummy run tellraw @a [{"text":"Les Pigeons n'ont pas atteint le nombre de kills minimum, ÉGALITÉ","color":"yellow","bold":true}]
execute if score #pigeons_minutes sgp.timer matches 10 if score #chasseurs_tues sgp.dummy < #pigeons_joueurs sgp.dummy run title @a title [{"text":"ÉGALITÉ","color":"yellow","bold":true}]

execute if score #pigeons_minutes sgp.timer matches 10 run function sgp.majeurs:pigeons/_stop