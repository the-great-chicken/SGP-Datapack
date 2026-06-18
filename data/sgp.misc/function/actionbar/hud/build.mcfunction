#> sgp.misc:actionbar/hud/build
#
# Builds the per-player zero-width actionbar HUD overlay immediately before
# Actionbar Mixer displays the current player's actionbar.

# The storage is global, but this function is called from display/self as each
# player, so it is safe to rebuild it for the current @s just before `title`.
data remove storage sgp:actionbar_hud overlay

execute unless score @s sgp.ab.hud_ability matches 1 run return 0

function sgp.misc:actionbar/hud/build_width

scoreboard players operation #sgp.ab.hud_space sgp.dummy = @s sgp.ab.normal_width
scoreboard players operation #sgp.ab.hud_space sgp.dummy += 1 sgp.dummy
scoreboard players operation #sgp.ab.hud_space sgp.dummy /= 4 sgp.dummy
scoreboard players operation #sgp.ab.hud_space sgp.dummy += #sgp.ab.hud_x sgp.dummy
execute if score #sgp.ab.hud_space sgp.dummy matches ..0 run \
    scoreboard players set #sgp.ab.hud_space sgp.dummy 0

execute if score #sgp.ab.hud_space sgp.dummy > #sgp.ab.space_limit sgp.dummy \
    run scoreboard players operation #sgp.ab.hud_space sgp.dummy = #sgp.ab.space_limit sgp.dummy

# Look up the actual glyph advance width for the current fill state.
# This keeps the overlay prefix zero-width even if the bitmap glyph widths are not mathematically linear.
execute store result storage sgp:macro actionbar_hud.index int 1 run scoreboard players get @s sgp.ab.hud_ability_fill
data modify storage sgp:macro actionbar_hud.function set value "sgp.misc:actionbar/hud/set_fill_width"
data modify storage sgp:macro actionbar_hud.list set value "sgp:data misc.actionbar.hud.ability_bar_widths"
function sgp.misc:run_with_dynamic_list_index with storage sgp:macro actionbar_hud

# Move to the fixed HUD x-position.
execute store result storage sgp:macro actionbar_hud.index int 1 run scoreboard players get #sgp.ab.hud_space sgp.dummy
data modify storage sgp:macro actionbar_hud.function set value "sgp.misc:actionbar/hud/append_positive_space"
data modify storage sgp:macro actionbar_hud.list set value "sgp:data misc.actionbar.hud.space_positive"
function sgp.misc:run_with_dynamic_list_index with storage sgp:macro actionbar_hud

# Background: always draw the full empty bar in white.
scoreboard players operation #sgp.ab.hud_background_fill sgp.dummy = #sgp.ab.bar_length sgp.dummy
execute store result storage sgp:macro actionbar_hud.index int 1 run scoreboard players get #sgp.ab.hud_background_fill sgp.dummy
data modify storage sgp:macro actionbar_hud.function set value "sgp.misc:actionbar/hud/append_ability_bar"
data modify storage sgp:macro actionbar_hud.list set value "sgp:data misc.actionbar.hud.ability_bars"
function sgp.misc:run_with_dynamic_list_index with storage sgp:macro actionbar_hud

# Rewind by the full bar width so the filled bar starts exactly on top of the background.
execute store result storage sgp:macro actionbar_hud.index int 1 run scoreboard players get #sgp.ab.hud_bar_width sgp.dummy
data modify storage sgp:macro actionbar_hud.function set value "sgp.misc:actionbar/hud/append_negative_space"
data modify storage sgp:macro actionbar_hud.list set value "sgp:data misc.actionbar.hud.space_negative"
function sgp.misc:run_with_dynamic_list_index with storage sgp:macro actionbar_hud

# Fill: draw the current bar amount tinted to the player's kit color.
execute store result storage sgp:macro actionbar_hud.index int 1 run scoreboard players get @s sgp.ab.hud_ability_fill
data modify storage sgp:macro actionbar_hud.function set value "sgp.misc:actionbar/hud/prepare_ability_fill_bar"
data modify storage sgp:macro actionbar_hud.list set value "sgp:data misc.actionbar.hud.ability_bars"
function sgp.misc:run_with_dynamic_list_index with storage sgp:macro actionbar_hud

# Rewind by S plus the actual current fill width to keep the prefix zero-width.
scoreboard players operation #sgp.ab.hud_space_back sgp.dummy = #sgp.ab.hud_space sgp.dummy
scoreboard players operation #sgp.ab.hud_space_back sgp.dummy += #sgp.ab.hud_fill_width sgp.dummy
execute if score #sgp.ab.hud_space_back sgp.dummy > #sgp.ab.space_limit sgp.dummy \
    run scoreboard players operation #sgp.ab.hud_space_back sgp.dummy = #sgp.ab.space_limit sgp.dummy

execute store result storage sgp:macro actionbar_hud.index int 1 run scoreboard players get #sgp.ab.hud_space_back sgp.dummy
data modify storage sgp:macro actionbar_hud.function set value "sgp.misc:actionbar/hud/append_negative_space"
data modify storage sgp:macro actionbar_hud.list set value "sgp:data misc.actionbar.hud.space_negative"
function sgp.misc:run_with_dynamic_list_index with storage sgp:macro actionbar_hud