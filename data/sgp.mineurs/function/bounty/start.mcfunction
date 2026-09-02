#> sgp.mineurs:bounty/start

function sgp.misc:selected_player/main {div:7, tag:sgp.wanted, sign:'/', add:1}

# Do not start an empty bounty when no non-peaceful player is eligible.
execute unless entity @a[tag=sgp.wanted] run return 0

execute as @a[tag=sgp.wanted] run function sgp.mineurs:bounty/init_wanted
title @a[tag=sgp.in_game] title {text:"Bounty !", color:yellow, bold:true}

tellraw @a[tag=sgp.in_game] [{storage:"sgp:text", nbt:"prefix", interpret:true}, {text:"BOUNTY! ",color:yellow, bold:true}, {text:"Les personnes recherchées sont ", color: yellow},{selector:"@a[tag=sgp.wanted]", color: white}]

function sgp.mineurs:common/timed_event/start {event:"bounty", duration:150}
schedule function sgp.mineurs:bounty/end 150s
