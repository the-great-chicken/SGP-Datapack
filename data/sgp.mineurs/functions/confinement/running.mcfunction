scoreboard players add #confines_ticks sgp.timer 1
execute if score #confines_ticks sgp.timer matches 0 run experience add @a[tag=in_game] -1 levels

# Démarrage de l'event après x secondes
execute if score #confines_secondes sgp.timer matches 19 if score #confines_ticks sgp.timer matches 0 if score #confines_minutes sgp.timer matches 0 run tellraw @a[tag=in_game] ["",{"text":"CONFINEMENT ! ", "color":"gray", "bold":true},{"text":"L'événement a commencé et se terminera dans 3 minutes !", "color":"white"}]
execute if score #confines_secondes sgp.timer matches 19 if score #confines_ticks sgp.timer matches 0 if score #confines_minutes sgp.timer matches 0 run stopsound @a[tag=in_game] master minecraft:music_disc.strad

# Faits des dégâts quand les joueurs ne sont pas en Intérieur
execute if score #confines_secondes sgp.timer matches 19.. if score #confines_minutes sgp.timer matches 0 if score #confines_ticks sgp.timer matches 0 as @a[tag=in_game] at @s unless block ~ ~1 ~ #sgp.mineurs:confinement_invincible unless block ~ ~ ~ #sgp.mineurs:confinement_invincible unless block ~1 ~1 ~ #sgp.mineurs:confinement_invincible unless block ~ ~1 ~1 #sgp.mineurs:confinement_invincible unless block ~ ~1 ~-1 #sgp.mineurs:confinement_invincible unless block ~-1 ~1 ~ #sgp.mineurs:confinement_invincible unless block ~ ~2 ~ #sgp.mineurs:confinement_invincible run title @s title "Rentrez en Intérieur !"
execute if score #confines_secondes sgp.timer matches 19.. if score #confines_minutes sgp.timer matches 0 if score #confines_ticks sgp.timer matches 0 as @a[tag=in_game] at @s unless block ~ ~1 ~ #sgp.mineurs:confinement_invincible unless block ~ ~ ~ #sgp.mineurs:confinement_invincible unless block ~1 ~1 ~ #sgp.mineurs:confinement_invincible unless block ~ ~1 ~1 #sgp.mineurs:confinement_invincible unless block ~ ~1 ~-1 #sgp.mineurs:confinement_invincible unless block ~-1 ~1 ~ #sgp.mineurs:confinement_invincible unless block ~ ~2 ~ #sgp.mineurs:confinement_invincible run damage @s 4 starve
execute unless score #confines_minutes sgp.timer matches 0 if score #confines_ticks sgp.timer matches 0 as @a[tag=in_game] at @s unless block ~ ~1 ~ #sgp.mineurs:confinement_invincible unless block ~ ~ ~ #sgp.mineurs:confinement_invincible unless block ~1 ~1 ~ #sgp.mineurs:confinement_invincible unless block ~ ~1 ~1 #sgp.mineurs:confinement_invincible unless block ~ ~1 ~-1 #sgp.mineurs:confinement_invincible unless block ~-1 ~1 ~ #sgp.mineurs:confinement_invincible unless block ~ ~2 ~ #sgp.mineurs:confinement_invincible run title @s title "Rentrez en Intérieur !"
execute unless score #confines_minutes sgp.timer matches 0 if score #confines_ticks sgp.timer matches 0 as @a[tag=in_game] at @s unless block ~ ~1 ~ #sgp.mineurs:confinement_invincible unless block ~ ~ ~ #sgp.mineurs:confinement_invincible unless block ~1 ~1 ~ #sgp.mineurs:confinement_invincible unless block ~ ~1 ~1 #sgp.mineurs:confinement_invincible unless block ~ ~1 ~-1 #sgp.mineurs:confinement_invincible unless block ~-1 ~1 ~ #sgp.mineurs:confinement_invincible unless block ~ ~2 ~ #sgp.mineurs:confinement_invincible run damage @s 4 starve

# Passage à la seconde supérieure
execute if score #confines_ticks sgp.timer matches 20 run scoreboard players add #confines_secondes sgp.timer 1
execute if score #confines_ticks sgp.timer matches 20 run scoreboard players set #confines_ticks sgp.timer -1

# Passage à la minute supérieure
execute if score #confines_secondes sgp.timer matches 60 run scoreboard players add #confines_minutes sgp.timer 1
execute if score #confines_secondes sgp.timer matches 60 run scoreboard players set #confines_secondes sgp.timer 0

# Récursivité
execute unless score #confines_minutes sgp.timer matches 3 run schedule function sgp.mineurs:confinement/running 1

# Fin de l'event
execute if score #confines_minutes sgp.timer matches 3 run tellraw @a[tag=in_game] ["",{"text":"CONFINEMENT ! ", "color":"gray", "bold":true},{"text":"L'événement est terminé ! Vous pouvez ressortir en toute securité !", "color":"white"}]
execute if score #confines_minutes sgp.timer matches 3 run experience set @a[tag=in_game] 0 levels
execute if score #confines_minutes sgp.timer matches 3 run scoreboard players set #confines_minutes sgp.timer 0