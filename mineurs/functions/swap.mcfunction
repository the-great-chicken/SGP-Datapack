tellraw @a ["",{"text":"SWAP! ","color":"dark_green","bold":true},{"text":"Le Canarchimage a remplacé le kit de tout le monde par un kit Aléatoire !","color":"green"}]
title @a title {"text":"SWAP!","color":"dark_green","bold":true}
scoreboard players enable @a veut_random
execute as @a run trigger veut_random