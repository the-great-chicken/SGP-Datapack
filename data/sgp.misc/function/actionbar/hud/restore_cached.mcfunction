#> sgp.misc:actionbar/hud/restore_cached
#
# The signature is unchanged: reuse the overlay cached in the player's Mixer entry.

execute if score @s sgp.ab.hud_sig matches -1 run return run data remove storage sgp:actionbar_hud overlay
data modify storage sgp:actionbar_hud overlay set from storage dah:actbar data[0].sgp_hud
