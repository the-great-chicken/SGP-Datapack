execute as @a[tag=in_game,tag=!reflexes_check] at @s run summon tnt
tag @a[tag=reflexes_check] remove reflexes_check
scoreboard players reset @a sgp.reflexes_joueur