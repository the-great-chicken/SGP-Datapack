#> sgp.misc:actionbar/water_trident_cooldown_clear
#
# Clears the normal Actionbar Mixer segment and tracking scores used by the
# Poseidon water-trident cooldown.

function dah.actbar_mixer:remove/this {id:"sgp:water_trident_cooldown"}
scoreboard players reset @s sgp.ab.water_trident_cooldown
scoreboard players reset @s sgp.ab.water_trident_cooldown_max
scoreboard players reset @s sgp.ab.water_trident_cooldown_last_fill
scoreboard players reset @s sgp.ab.water_trident_cooldown_last_current
