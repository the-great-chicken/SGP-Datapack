#> sgp.majeurs:hide_and_seek/actionbar/clear
#
# Clear the current player's Cache-cache hiding timer actionbar segment.

function dah.actbar_mixer:remove/this {id:"sgp:hide_hider"}
scoreboard players reset @s sgp.ab.hide_hider
