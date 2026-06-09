#> sgp.majeurs:hide_and_seek/_stop
#
# Stop the hide and seek game.

#win for the hiders
execute if entity @a[tag=sgp.hider] run title @a[tag=sgp.in_game] title [{text:"La Volaille a gagné !", color:red}]
execute if entity @a[tag=sgp.hider] run tellraw @a[tag=sgp.in_game] [{storage:"sgp.text", nbt:"prefix", interpret:true}, {text:"La ", color:gold},{text:"Volaille", color:yellow}, {text:" a survécu 5 minutes", color:gold}]

#reset all players
scoreboard players reset * sgp.link_teams
execute as @a[tag=sgp.in_game] run function sgp.majeurs:hide_and_seek/reset_player

#stop the game
scoreboard players set #second sgp.timer 0

function #bs.schedule:cancel_all {with:{id:"hide_and_seek"}}
schedule clear sgp.majeurs:hide_and_seek/_stop
schedule clear sgp.majeurs:hide_and_seek/timer/seeker
schedule clear sgp.majeurs:hide_and_seek/timer/hider
schedule clear sgp.majeurs:hide_and_seek/timer/glow
schedule clear sgp.majeurs:hide_and_seek/timer/glow_announce

function sgp.majeurs:common/stop
function sgp.majeurs:common/rounds with storage sgp:data majeurs.hide_and_seek