tellraw @a[tag=in_game] ["",{"text":"SWAP! ", "color":"dark_green", "bold":true},{"text":"Le Canarchimage a remplacé le kit de tout le monde par un kit Aléatoire !", "color":"green"}]
title @a[tag=in_game] title {"text":"SWAP!", "color":"dark_green", "bold":true}
scoreboard players enable @a[tag=in_game] sgp.veut_random
execute as @a[tag=in_game] run trigger sgp.veut_random