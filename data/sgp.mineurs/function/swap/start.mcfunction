#> sgp.mineurs:swap/start

tellraw @a[tag=sgp.in_game] [{storage:"sgp:text", nbt:"prefix", interpret:true}, {text:"SWAP! ", color:dark_green, bold:true}, \
                            {text:"Le Canarchimage a remplacé le kit de tout le monde par un kit Aléatoire !", color:green}]

title @a[tag=sgp.in_game] title {text:"SWAP!", color:dark_green, bold:true}

execute as @a[tag=sgp.in_game] run function sgp.kits:random_kit