#> sgp.world:reward/laby
# 
# Check if a player triggered the reward of laby,
# and gives it to him if so

execute at @e[type=marker,tag=sgp.marker,name="laby_fin"] as @s[scores={sgp.laby_fin=0},distance=..0.5] run scoreboard players enable @s sgp.laby_fin
execute at @e[type=marker,tag=sgp.marker,name="laby_fin"] as @s[scores={sgp.laby_fin=0},distance=..0.5] run scoreboard players set @s sgp.laby_fin 1
execute at @e[type=marker,tag=sgp.marker,name="laby_fin"] as @s[scores={sgp.laby_fin=1},distance=0.5..] run trigger sgp.laby_fin set 0

execute as @s[scores={sgp.laby_fin=2}] run tp @s 2525 205 2191 -90 0
execute as @s[scores={sgp.laby_fin=2}] run scoreboard players add #nbr_joueurs sgp.laby_fin 1

execute as @s[scores={sgp.laby_fin=2}] run \
    tellraw @a [{"storage":"sgp.text", "nbt":"prefix", "interpret":true}, {"selector":"@s", "color":"yellow"}, {"text":" est la ", "color":"aqua"}, {"score":{"name":"#nbr_joueurs","objective":"sgp.laby_fin"}}, {"text":"e personne a avoir fini le ", "color":"aqua"}, {"text":"Labyrinthe", "color":"light_purple", "bold":true}, {"text":" ! Bravo à eux !", "color":"aqua"}]

execute as @s[scores={sgp.laby_fin=2}] run \
    tellraw @s [{"storage":"sgp.text", "nbt":"prefix", "interpret":true}, {"text":"Tu as débloqué le Kill Effect ", "color":"aqua"}, {"text":"Portail", "color":"dark_purple", "bold":true},{"text":" ! \n \
        Tu peux l'activer en allant dans la salle des ","color":"aqua"}, {"text":"cosmétiques", "color":"light_purple"}, {"text":" depuis l'accueil", "color":"aqua"}]

scoreboard players set @s[scores={sgp.laby_fin=2}] sgp.portal_kill_unlocked 1
execute as @s[scores={sgp.laby_fin=2}] run scoreboard players set @s sgp.laby_fin 3