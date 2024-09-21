#> sgp.mineurs:bounty/start
#
# start the bounty minor event

function sgp.misc:selected_player/main {div:7, tag:sgp.wanted, sign:'/'}

execute as @a[tag=sgp.wanted] run function sgp.mineurs:bounty/init_wanted
title @a[tag=sgp.in_game] title {"type":"translatable", "translate":"sgp.minor:bounty_name", "fallback":"BOUNTY! ", "color":"yellow", "bold":true}

tellraw @a [{"storage":"sgp.text", "nbt":"prefix", "interpret":true}, {"type":"translatable", "translate":"sgp.minor:bounty_name", "fallback":"BOUNTY! ", "color":"yellow", "bold":true}, {"type":"translatable", "translate":"sgp.minor:bounty_wanted_people", "fallback":[{"text":"Les personnes recherchées sont ", "color": "yellow"},{"selector":"@a[tag=sgp.wanted]", "color": "white"}], "color":"yellow", "with":[{"selector":"@a[tag=sgp.wanted]", "color": "white"}]}]

function sgp.misc:timer_experience {duration:120}

schedule function sgp.mineurs:bounty/end 120s