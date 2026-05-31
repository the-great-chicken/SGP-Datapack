#> sgp.mineurs:reflexes/end

execute as @a[tag=sgp.in_game,tag=!sgp.reflexes_check] at @s run summon tnt ~ ~ ~ {fuse:1}
tag @a[tag=sgp.reflexes_check] remove sgp.reflexes_check
scoreboard players reset @a sgp.reflexes_joueur