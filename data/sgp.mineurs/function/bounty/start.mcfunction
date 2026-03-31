#> sgp.mineurs:bounty/start
#
# start the bounty minor event

function sgp.misc:selected_player/main {div:7, tag:sgp.wanted, sign:'/'}

execute as @a[tag=sgp.wanted] run function sgp.mineurs:bounty/init_wanted
title @a[tag=sgp.in_game] title {"translate":"sgp.mineurs:bounty_title", "fallback":"Bounty !", "color":"yellow", "bold":true}

tellraw @a [{"storage":"sgp.text", "nbt":"prefix", "interpret":true}, {"translate":"sgp.mineurs:bounty_start", "fallback":"%s Les personnes recherchées sont %s", "color":"yellow", "with":[{"translate":"sgp.mineurs:bounty_prefix", "fallback":"BOUNTY!", "color":"yellow", "bold":true}, {"selector":"@a[tag=sgp.wanted]", "color": "white"}]}]

function sgp.misc:timer_experience {duration:120}

schedule function sgp.mineurs:bounty/end 120s