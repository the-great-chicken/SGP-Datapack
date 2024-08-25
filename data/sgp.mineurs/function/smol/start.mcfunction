title @a[tag=sgp.in_game] title {"text":"SMOL!", "color":"blue", "bold":true}
tellraw @a[tag=sgp.in_game] [{"storage":"sgp.text", "nbt":"prefix", "interpret":true}, {"text":"SMOL! ", "color":"blue", "bold":true},{"text":"Le Canarchimage a divisé la taille de tout le monde par 2 !", "color":"blue"}]

scoreboard players set #smol_seconds sgp.dummy 0

experience set @a[tag=sgp.in_game] 150 levels

execute as @a[tag=sgp.in_game] \
    run attribute @s minecraft:generic.scale modifier add sgp.smol -0.5 add_multiplied_total

function sgp.mineurs:smol/running