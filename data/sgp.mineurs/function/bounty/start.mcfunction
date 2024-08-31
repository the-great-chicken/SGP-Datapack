#> sgp.mineurs:bounty/start
#
# start the bounty minor event

function sgp.misc:selected_player/main {div:7, tag:sgp.wanted, sign:'/'}

execute as @a[tag=sgp.wanted] run function sgp.mineurs:bounty/init_wanted
title @a[tag=sgp.in_game] title {"text":"Bounty !", "color":"yellow", "bold":true}

tellraw @a [{"storage":"sgp.text", "nbt":"prefix", "interpret":true}, {"text":"BOUNTY! ","color":"yellow", "bold":true}, {"text":"Les personnes recherchées sont ", "color": "yellow"},{"selector":"@a[tag=sgp.wanted]", "color": "white"}]

function sgp.misc:timer_experience {duration:120}

schedule function sgp.mineurs:bounty/end 120s