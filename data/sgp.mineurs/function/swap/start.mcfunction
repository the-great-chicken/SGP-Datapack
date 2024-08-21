tellraw @a[tag=sgp.in_game] [{"storage":"sgp.text", "nbt":"prefix", "interpret":true}, {"text":"SWAP! ", "color":"dark_green", "bold":true}, {"text":"Le Canarchimage a remplacé le kit de tout le monde par un kit Aléatoire !", "color":"green"}]
title @a[tag=sgp.in_game] title {"text":"SWAP!", "color":"dark_green", "bold":true}

scoreboard players enable @a[tag=sgp.in_game] sgp.veut_random
execute as @a[tag=sgp.in_game] run trigger sgp.veut_random