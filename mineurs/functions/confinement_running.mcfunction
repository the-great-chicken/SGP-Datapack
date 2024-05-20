scoreboard players add #confines_ticks timer 1
execute if score #confines_ticks timer matches 0 run experience add @a -1 levels

# Démarrage de l'event après x secondes
execute if score #confines_secondes timer matches 19 if score #confines_ticks timer matches 0 if score #confines_minutes timer matches 0 run tellraw @a ["",{"text":"CONFINEMENT ! ", "color":"gray", "bold":true},{"text":"L'événement a commencé et se terminera dans 3 minutes !", "color":"white"}]
execute if score #confines_secondes timer matches 19 if score #confines_ticks timer matches 0 if score #confines_minutes timer matches 0 run stopsound @a ambient minecraft:music_disc.strad

# Faits des dégâts quand les joueurs ne sont pas en Intérieur
execute if score #confines_secondes timer >= 19 dummy if score #confines_ticks timer matches 0 in minisjeux_crea as @a[x=2405,y=201,z=2133,dx=137,dy=49,dz=72] at @s unless block ~ ~1 ~ #mineurs:confinement_invincible unless block ~ ~ ~ #mineurs:confinement_invincible unless block ~1 ~1 ~ #mineurs:confinement_invincible unless block ~ ~1 ~1 #mineurs:confinement_invincible unless block ~ ~1 ~-1 #mineurs:confinement_invincible unless block ~-1 ~1 ~ #mineurs:confinement_invincible unless block ~ ~2 ~ #mineurs:confinement_invincible run title @s title "Rentrez en Intérieur !"
execute if score #confines_secondes timer >= 19 dummy if score #confines_ticks timer matches 0 in minisjeux_crea as @a[x=2405,y=201,z=2133,dx=137,dy=49,dz=72] at @s unless block ~ ~1 ~ #mineurs:confinement_invincible unless block ~ ~ ~ #mineurs:confinement_invincible unless block ~1 ~1 ~ #mineurs:confinement_invincible unless block ~ ~1 ~1 #mineurs:confinement_invincible unless block ~ ~1 ~-1 #mineurs:confinement_invincible unless block ~-1 ~1 ~ #mineurs:confinement_invincible unless block ~ ~2 ~ #mineurs:confinement_invincible run damage @s 4 starve

# Passage à la seconde supérieure
execute if score #confines_ticks timer matches 20 run scoreboard players add #confines_secondes timer 1
execute if score #confines_ticks timer matches 20 run scoreboard players set #confines_ticks timer -1

# Passage à la minute supérieure
execute if score #confines_secondes timer matches 60 run scoreboard players add #confines_minutes timer 1
execute if score #confines_secondes timer matches 60 run scoreboard players set #confines_secondes timer 0

# Récursivité
execute unless score #confines_minutes timer matches 3 run schedule function mineurs:confinement_running 1

# Fin de l'event
execute if score #confines_minutes timer matches 3 run tellraw @a ["",{"text":"CONFINEMENT ! ", "color":"gray", "bold":true},{"text":"L'événement est terminé ! Vous pouvez ressortir en toute securité !", "color":"white"}]
execute if score #confines_minutes timer matches 3 run experience set @a 0 levels
execute if score #confines_minutes timer matches 3 run scoreboard players set #confines_minutes timer 0