#> sgp.misc:actionbar/clear
#
# Clears all SGP-owned Actionbar Mixer segments for the current player.

function dah.actbar_mixer:remove/this {id:"sgp:reward_1"}
function dah.actbar_mixer:remove/this {id:"sgp:reward_2"}
function dah.actbar_mixer:remove/this {id:"sgp:reward_3"}
function dah.actbar_mixer:remove/this {id:"sgp:hide_hider"}
function dah.actbar_mixer:remove/this {id:"sgp:pco_cabane"}

scoreboard players reset @s sgp.ab.reward_1
scoreboard players reset @s sgp.ab.reward_1_width
scoreboard players reset @s sgp.ab.reward_2
scoreboard players reset @s sgp.ab.reward_2_width
scoreboard players reset @s sgp.ab.reward_3
scoreboard players reset @s sgp.ab.reward_3_width

tag @s add sgp.ab.location_clear_target
function sgp.misc:loop_as_entity/init {list_location:"markers_lists.location", command:"run function sgp.misc:actionbar/location_clear_for_target with entity @s data"}
tag @s remove sgp.ab.location_clear_target

scoreboard players reset @s sgp.ab.location
scoreboard players reset @s sgp.ab.location_width
scoreboard players reset @s sgp.ab.hide_hider
scoreboard players reset @s sgp.ab.pco_cabane
function sgp.misc:actionbar/water_trident_cooldown_clear
scoreboard players reset @s sgp.ab.normal_width
scoreboard players reset @s sgp.ab.normal_count

function sgp.misc:actionbar/ability_cooldown_clear