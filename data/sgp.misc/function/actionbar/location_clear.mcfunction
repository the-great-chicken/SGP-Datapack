#> sgp.misc:actionbar/location_clear
#
# Clears the persistent location actionbar segment once the player is no
# longer inside any location.

function dah.actbar_mixer:remove/this {id:"sgp:location"}
scoreboard players reset @s sgp.ab.location
scoreboard players reset @s sgp.ab.location_width
