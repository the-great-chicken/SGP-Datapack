#> sgp.misc:actionbar/clear
#
# Clears all SGP-owned Actionbar Mixer segments for the current player.

function dah.actbar_mixer:remove/this {id:"sgp:reward"}
function dah.actbar_mixer:remove/this {id:"sgp:reward_1"}
function dah.actbar_mixer:remove/this {id:"sgp:reward_2"}
function dah.actbar_mixer:remove/this {id:"sgp:reward_3"}
function dah.actbar_mixer:remove/this {id:"sgp:location"}
function dah.actbar_mixer:remove/this {id:"sgp:hide_hider"}
function dah.actbar_mixer:remove/this {id:"sgp:pco_cabane"}

scoreboard players reset @s sgp.ab.reward_1
scoreboard players reset @s sgp.ab.reward_2
scoreboard players reset @s sgp.ab.reward_3
scoreboard players reset @s sgp.ab.location
scoreboard players reset @s sgp.ab.hide_hider
scoreboard players reset @s sgp.ab.pco_cabane
