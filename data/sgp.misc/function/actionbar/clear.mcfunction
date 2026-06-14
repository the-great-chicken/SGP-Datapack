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
function dah.actbar_mixer:remove/this {id:"sgp:water_trident_cooldown"}

scoreboard players reset @s sgp.ab.reward_1
scoreboard players reset @s sgp.ab.reward_1_width
scoreboard players reset @s sgp.ab.reward_2
scoreboard players reset @s sgp.ab.reward_2_width
scoreboard players reset @s sgp.ab.reward_3
scoreboard players reset @s sgp.ab.reward_3_width
scoreboard players reset @s sgp.ab.location
scoreboard players reset @s sgp.ab.location_width
scoreboard players reset @s sgp.ab.hide_hider
scoreboard players reset @s sgp.ab.pco_cabane
function sgp.misc:actionbar/water_trident_cooldown_clear
scoreboard players reset @s sgp.ab.normal_width
scoreboard players reset @s sgp.ab.normal_count

function sgp.misc:actionbar/ability_cooldown_clear