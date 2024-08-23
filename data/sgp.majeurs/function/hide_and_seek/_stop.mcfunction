#> sgp.majeurs:hide_and_seek/_stop
#
# Stop the hide and seek game.

execute unless entity @a[team=sgp.hider] run title @a[tag=sgp.in_game] actionbar [{"text":"La volaille a gagné !","color":"red"}]

effect clear @a[tag=sgp.in_game]
scoreboard players reset * sgp.link_teams
team leave @a[tag=sgp.in_game]



schedule clear sgp.majeurs:hide_and_seek/_stop

function sgp.majeurs:common/stop

function sgp.majeurs:common/rounds with storage sgp:data majeurs.hide_and_seek