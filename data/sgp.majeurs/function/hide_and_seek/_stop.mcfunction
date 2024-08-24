#> sgp.majeurs:hide_and_seek/_stop
#
# Stop the hide and seek game.

#win for the hiders
execute unless entity @a[team=sgp.hider] run title @a[tag=sgp.in_game] title [{"text":"La volaille a gagné !","color":"red"}]

#reset all players
scoreboard players reset * sgp.link_teams
execute as @a[tag=sgp.in_game] run function sgp.majeurs:hide_and_seek/reset_player

#stop the game
function #bs.schedule:cancel_all {with:{}}
schedule clear sgp.majeurs:hide_and_seek/_stop
function sgp.majeurs:common/stop
function sgp.majeurs:common/rounds with storage sgp:data majeurs.hide_and_seek