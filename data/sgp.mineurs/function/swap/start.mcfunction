tellraw @a[tag=sgp.in_game] [{"storage":"sgp.text", "nbt":"prefix", "interpret":true}, {"translate":"sgp.mineurs:swap_start", "fallback":"%s Le Canarchimage a remplacé le kit de tout le monde par un kit Aléatoire !", "color":"green", "with":[{"translate":"sgp.mineurs:swap_prefix", "fallback":"SWAP!", "color":"dark_green", "bold":true}]}]
title @a[tag=sgp.in_game] title {"translate":"sgp.mineurs:swap_prefix", "fallback":"SWAP!", "color":"dark_green", "bold":true}

scoreboard players enable @a[tag=sgp.in_game] sgp.veut_random
execute as @a[tag=sgp.in_game] run trigger sgp.veut_random