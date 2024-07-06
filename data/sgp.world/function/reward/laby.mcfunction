#> sgp.world:reward/laby
# 
# Check if a player triggered the reward of laby,
# and gives it to him if so

execute at @e[type=marker,tag=sgp.marker,name="laby_fin"] as @s[scores={sgp.laby_fin=0},distance=..0.5] run scoreboard players enable @s sgp.laby_fin
execute at @e[type=marker,tag=sgp.marker,name="laby_fin"] as @s[scores={sgp.laby_fin=0},distance=..0.5] run scoreboard players set @s sgp.laby_fin 1
execute at @e[type=marker,tag=sgp.marker,name="laby_fin"] as @s[scores={sgp.laby_fin=1},distance=0.5..] run trigger sgp.laby_fin set 0
execute as @s[scores={sgp.laby_fin=2}] run tp @s 2525 205 2191 -90 0
execute as @s[scores={sgp.laby_fin=2}] run scoreboard players add #nbr_joueurs sgp.laby_fin 1
execute as @s[scores={sgp.laby_fin=2}] run tellraw @a ["",{"selector":"@s", "color":"yellow"}," est la ",{"score":{"name":"#nbr_joueurs","objective":"sgp.laby_fin"}},"e personne a avoir fini le ",{"text":"Labyrinthe", "color":"light_purple", "bold":true}," ! Bravo à eux !"]
execute as @s[scores={sgp.laby_fin=2}] run tellraw @s ["Tu as débloqué le Kill Effect ",{"text":"Portail", "color":"dark_purple", "bold":true}," ! \nTu peux l'activer en allant dans la salle des ",{"text":"cosmétiques", "color":"light_purple"}," depuis l'accueil"]
scoreboard players set @s[scores={sgp.laby_fin=2}] sgp.portal_kill_unlocked 1
execute as @s[scores={sgp.laby_fin=2}] run scoreboard players set @s sgp.laby_fin 3