#> sgp.world:reward/laby
# 
# Check if a player triggered the reward of laby,
# and gives it to him if so

execute at @e[type=marker,tag=sgp.marker,name="laby_fin",limit=1] as @s[scores={sgp.laby_fin=0},distance=..0.5] run scoreboard players enable @s sgp.laby_fin
execute at @e[type=marker,tag=sgp.marker,name="laby_fin",limit=1] as @s[scores={sgp.laby_fin=0},distance=..0.5] run scoreboard players set @s sgp.laby_fin 1
execute at @e[type=marker,tag=sgp.marker,name="laby_fin",limit=1] as @s[scores={sgp.laby_fin=1},distance=0.5..] run trigger sgp.laby_fin set 0

execute as @s[scores={sgp.laby_fin=2}] run tp @s 2525 205 2191 -90 0
execute as @s[scores={sgp.laby_fin=2}] run scoreboard players add #nbr_joueurs sgp.laby_fin 1

execute as @s[scores={sgp.laby_fin=2}] run \
    tellraw @a [{"storage":"sgp.text", "nbt":"prefix", "interpret":true}, {"translate":"sgp.world:laby_finished_announcement", "fallback":"%s est la %se personne a avoir fini le %s ! Bravo à eux !", "color":"aqua", "with":[{"selector":"@s", "color":"yellow"}, {"score":{"name":"#nbr_joueurs","objective":"sgp.laby_fin"}, "color":"white"}, {"translate":"sgp.world:labyrinth", "fallback":"Labyrinthe", "color":"light_purple", "bold":true}]}]

execute as @s[scores={sgp.laby_fin=2}] run \
    tellraw @s [{"storage":"sgp.text", "nbt":"prefix", "interpret":true}, {"translate":"sgp.world:unlocked_portal_kill_effect", "fallback":"Tu as débloqué le Kill Effect %s ! \n \
        Tu peux l'activer en allant dans la salle des %s depuis l'accueil", "color":"aqua", "with":[{"translate":"sgp.world:kill_effect_portal", "fallback":"Portail", "color":"dark_purple", "bold":true}, {"translate":"sgp.world:cosmetics", "fallback":"cosmétiques", "color":"light_purple"}]}]

scoreboard players set @s[scores={sgp.laby_fin=2}] sgp.portal_kill_unlocked 1
execute as @s[scores={sgp.laby_fin=2}] run scoreboard players set @s sgp.laby_fin 3