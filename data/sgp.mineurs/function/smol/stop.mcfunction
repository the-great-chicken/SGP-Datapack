execute as @a[tag=sgp.in_game] \
    run attribute @s minecraft:generic.scale modifier remove sgp.smol

tellraw @a[tag=sgp.in_game] [{"storage":"sgp.text", "nbt":"prefix", "interpret":true}, {"text":"Le Canarchimage vous a rendu votre taille normale", "color":"blue"}]

experience set @a[tag=sgp.in_game] 0 levels
experience set @a[tag=sgp.in_game] 0 points