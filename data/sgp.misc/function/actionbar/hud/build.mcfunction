#> sgp.misc:actionbar/hud/build
#
# Builds the per-player zero-width actionbar HUD overlay immediately before
# Actionbar Mixer displays the current player's actionbar.

# The storage is global, but this function is called from display/self as each player, so it is safe to rebuild it for the current @s just before `title`.
data remove storage sgp:actionbar_hud overlay

execute unless score @s sgp.kit_id matches 0.. run return 0

execute unless score @s sgp.ab.hud_ability matches 1 run return 0

function sgp.misc:actionbar/hud/build_width
function sgp.misc:actionbar/hud/build_glyphs
