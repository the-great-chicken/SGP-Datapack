#> sgp.world:reward/laby
# 
# Check if a player triggered the reward of laby,
# and gives it to him if so

execute as @a[x=2511,y=229,z=2191,dx=0,dy=1,dz=0,scores={sgp.laby_fin=0}] unless entity @s[tag=eclaireur] unless entity @s[tag=enderman] unless entity @s[tag=pigeon] run scoreboard players enable @s sgp.laby_fin
execute as @a[x=2511,y=229,z=2191,dx=0,dy=1,dz=0,scores={sgp.laby_fin=0}] run scoreboard players set @s sgp.laby_fin 1
execute as @a[scores={sgp.laby_fin=2}] run tp @s 2525 205 2191 -90 0
execute as @a[scores={sgp.laby_fin=2}] run scoreboard players add #nbr_joueurs sgp.laby_fin 1
execute as @a[scores={sgp.laby_fin=2}] run tellraw @a ["",{"selector":"@s", "color":"yellow"}," est la ",{"score":{"name":"#nbr_joueurs","objective":"sgp.laby_fin"}},"e personne a avoir fini le ",{"text":"Labyrinthe", "color":"light_purple", "bold":true}," ! Bravo à eux !"]
execute as @a[scores={sgp.laby_fin=2}] run tellraw @s ["Tu as débloqué le Kill Effect ",{"text":"Portail", "color":"dark_purple", "bold":true}," ! \nTu peux l'activer en allant dans la salle des ",{"text":"cosmétiques", "color":"light_purple"}," depuis l'accueil"]
scoreboard players set @a[scores={sgp.laby_fin=2}] portal_kill_unlocked 1
execute as @a[scores={sgp.laby_fin=2}] run scoreboard players set @s sgp.laby_fin 3
execute as @a[scores={sgp.laby_fin=1}] unless entity @s[x=2511,y=229,z=2191,dx=0,dy=1,dz=0] run trigger sgp.laby_fin set 0