#> sgp.misc:actionbar/hud/rebuild_cached
#
# The signature changed: rebuild the overlay and cache it in the player's Mixer entry.

data remove storage sgp:actionbar_hud overlay
execute if score @s sgp.ab.hud_sig matches 0.. run function sgp.misc:actionbar/hud/build_glyphs
data modify storage dah:actbar data[0].sgp_hud set value []
execute if data storage sgp:actionbar_hud overlay run data modify storage dah:actbar data[0].sgp_hud set from storage sgp:actionbar_hud overlay
scoreboard players operation @s sgp.ab.hud_sig_cached = @s sgp.ab.hud_sig
