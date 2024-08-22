execute store result score #nbr_joueurs sgp.dummy if entity @a
execute store result storage sgp:data mineurs.bounty.nbr_wanted int 1 run scoreboard players operation #nbr_joueurs sgp.dummy /= 10 sgp.dummy
function sgp.mineurs:bounty/select_wanted with storage sgp:data mineurs.bounty

execute as @a[tag=sgp.wanted] run function sgp.mineurs:bounty/init_wanted
title @a[tag=sgp.in_game] title {"text":"Bounty !", "color":"yellow", "bold":true}

tellraw @a [{"storage":"sgp.text", "nbt":"prefix", "interpret":true},{"text":"Les personnes recherchés sont ","color": "yellow"},{"selector":"@a[tag=sgp.wanted]","color": "white"}]

schedule function sgp.mineurs:bounty/end 120s