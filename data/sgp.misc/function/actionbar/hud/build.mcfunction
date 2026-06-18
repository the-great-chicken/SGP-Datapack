#> sgp.misc:actionbar/hud/build
#
# Builds the per-player zero-width actionbar HUD overlay immediately before
# Actionbar Mixer displays the current player's actionbar.

# The storage is global, but this function is called from display/self as each player, so it is safe to rebuild it for the current @s just before `title`.
data remove storage sgp:actionbar_hud overlay

execute unless score @s sgp.kit_id matches 0.. run return 0

execute unless score @s sgp.ab.hud_ability matches 1 run return 0

# Select the current kit visual data once. Icon and color both come from sgp:kits.
data modify storage sgp:macro actionbar_hud.kit set value {kit_color:white, kit_icon:""}
execute store result storage sgp:macro actionbar_hud.index int 1 run scoreboard players get @s sgp.kit_id
data modify storage sgp:macro actionbar_hud.function set value "sgp.misc:actionbar/hud/select_current_kit"
data modify storage sgp:macro actionbar_hud.list set value "sgp:kits kit_id_order"
function sgp.misc:run_with_dynamic_list_index with storage sgp:macro actionbar_hud

function sgp.misc:actionbar/hud/build_width

# Move from the beginning of the centered normal actionbar line to the HUD glyph start position.
scoreboard players operation #sgp.ab.hud_space sgp.dummy = @s sgp.ab.normal_width
scoreboard players operation #sgp.ab.hud_space sgp.dummy += 1 sgp.dummy
scoreboard players operation #sgp.ab.hud_space sgp.dummy /= 4 sgp.dummy
scoreboard players operation #sgp.ab.hud_space sgp.dummy += #sgp.ab.hud_x sgp.dummy

# Clamp the signed offset to the available space glyph LUTs.
scoreboard players operation #sgp.ab.neg_space_limit sgp.dummy = #sgp.ab.space_limit sgp.dummy
scoreboard players operation #sgp.ab.neg_space_limit sgp.dummy *= -1 sgp.dummy
execute if score #sgp.ab.hud_space sgp.dummy > #sgp.ab.space_limit sgp.dummy run scoreboard players operation #sgp.ab.hud_space sgp.dummy = #sgp.ab.space_limit sgp.dummy
execute if score #sgp.ab.hud_space sgp.dummy < #sgp.ab.neg_space_limit sgp.dummy run scoreboard players operation #sgp.ab.hud_space sgp.dummy = #sgp.ab.neg_space_limit sgp.dummy

# Look up the actual glyph advance width for the current fill state.
# This remains a LUT so the HUD shape can be changed in the resource pack.
execute store result storage sgp:macro actionbar_hud.index int 1 run scoreboard players get @s sgp.ab.hud_ability_fill
data modify storage sgp:macro actionbar_hud.function set value "sgp.misc:actionbar/hud/set_fill_width"
data modify storage sgp:macro actionbar_hud.list set value "sgp:data misc.actionbar.hud.ability_bar_widths"
function sgp.misc:run_with_dynamic_list_index with storage sgp:macro actionbar_hud

# Apply the signed HUD offset.
scoreboard players operation #sgp.ab.hud_space_abs sgp.dummy = #sgp.ab.hud_space sgp.dummy
execute if score #sgp.ab.hud_space_abs sgp.dummy matches ..-1 run scoreboard players operation #sgp.ab.hud_space_abs sgp.dummy *= -1 sgp.dummy
execute store result storage sgp:macro actionbar_hud.index int 1 run scoreboard players get #sgp.ab.hud_space_abs sgp.dummy
execute if score #sgp.ab.hud_space sgp.dummy matches 0.. run data modify storage sgp:macro actionbar_hud.function set value "sgp.misc:actionbar/hud/append_positive_space"
execute if score #sgp.ab.hud_space sgp.dummy matches 0.. run data modify storage sgp:macro actionbar_hud.list set value "sgp:data misc.actionbar.hud.space_positive"
execute if score #sgp.ab.hud_space sgp.dummy matches ..-1 run data modify storage sgp:macro actionbar_hud.function set value "sgp.misc:actionbar/hud/append_negative_space"
execute if score #sgp.ab.hud_space sgp.dummy matches ..-1 run data modify storage sgp:macro actionbar_hud.list set value "sgp:data misc.actionbar.hud.space_negative"
function sgp.misc:run_with_dynamic_list_index with storage sgp:macro actionbar_hud

# Background: draw the current kit icon centered under the cooldown frame.
# There are special cases depending on the icon...
data modify storage sgp:actionbar_hud overlay append value {text:{translate:"sgp.kits.offset.p.7",font:"sgp.kits:space",shadow:false}}
execute if score @s sgp.kit_id matches 8 run data modify storage sgp:actionbar_hud overlay append value {text:{translate:"sgp.kits.offset.n.1",font:"sgp.kits:space",shadow:false}}
execute if score @s sgp.kit_id matches 4 run data modify storage sgp:actionbar_hud overlay append value {text:{translate:"sgp.kits.offset.n.1",font:"sgp.kits:space",shadow:false}}
execute if score @s sgp.kit_id matches 9 run data modify storage sgp:actionbar_hud overlay append value {text:{translate:"sgp.kits.offset.n.1",font:"sgp.kits:space",shadow:false}}
execute if score @s sgp.kit_id matches 1 run data modify storage sgp:actionbar_hud overlay append value {text:{translate:"sgp.kits.offset.n.1",font:"sgp.kits:space",shadow:false}}

function sgp.misc:actionbar/hud/append_ability_bar with storage sgp:macro actionbar_hud.kit

# Rewind by the static background advance so the filled frame starts on top.
data modify storage sgp:actionbar_hud overlay append value {text:{translate:"sgp.kits.offset.n.15",font:"sgp.kits:space",shadow:false}}
execute if score @s sgp.kit_id matches 8 run data modify storage sgp:actionbar_hud overlay append value {text:{translate:"sgp.kits.offset.p.2",font:"sgp.kits:space",shadow:false}}
execute if score @s sgp.kit_id matches 5 run data modify storage sgp:actionbar_hud overlay append value {text:{translate:"sgp.kits.offset.p.1",font:"sgp.kits:space",shadow:false}}
execute if score @s sgp.kit_id matches 1 run data modify storage sgp:actionbar_hud overlay append value {text:{translate:"sgp.kits.offset.p.1",font:"sgp.kits:space",shadow:false}}
execute if score @s sgp.kit_id matches 4 run data modify storage sgp:actionbar_hud overlay append value {text:{translate:"sgp.kits.offset.p.2",font:"sgp.kits:space",shadow:false}}

# Draw the current cooldown HUD frame tinted to the player's kit color.
execute store result storage sgp:macro actionbar_hud.index int 1 run scoreboard players get @s sgp.ab.hud_ability_fill
data modify storage sgp:macro actionbar_hud.function set value "sgp.misc:actionbar/hud/prepare_ability_fill_bar"
data modify storage sgp:macro actionbar_hud.list set value "sgp:data misc.actionbar.hud.ability_bars"
function sgp.misc:run_with_dynamic_list_index with storage sgp:macro actionbar_hud

# Return to zero width before the normal Actionbar Mixer content is rendered.
# This is the opposite of: signed offset + current glyph advance width.
scoreboard players operation #sgp.ab.hud_space_back sgp.dummy = #sgp.ab.hud_space sgp.dummy
scoreboard players operation #sgp.ab.hud_space_back sgp.dummy += #sgp.ab.hud_fill_width sgp.dummy
execute if score #sgp.ab.hud_space_back sgp.dummy > #sgp.ab.space_limit sgp.dummy run scoreboard players operation #sgp.ab.hud_space_back sgp.dummy = #sgp.ab.space_limit sgp.dummy
execute if score #sgp.ab.hud_space_back sgp.dummy < #sgp.ab.neg_space_limit sgp.dummy run scoreboard players operation #sgp.ab.hud_space_back sgp.dummy = #sgp.ab.neg_space_limit sgp.dummy

scoreboard players operation #sgp.ab.hud_space_back_abs sgp.dummy = #sgp.ab.hud_space_back sgp.dummy
execute if score #sgp.ab.hud_space_back_abs sgp.dummy matches ..-1 run scoreboard players operation #sgp.ab.hud_space_back_abs sgp.dummy *= -1 sgp.dummy
execute store result storage sgp:macro actionbar_hud.index int 1 run scoreboard players get #sgp.ab.hud_space_back_abs sgp.dummy
execute if score #sgp.ab.hud_space_back sgp.dummy matches 0.. run data modify storage sgp:macro actionbar_hud.function set value "sgp.misc:actionbar/hud/append_negative_space"
execute if score #sgp.ab.hud_space_back sgp.dummy matches 0.. run data modify storage sgp:macro actionbar_hud.list set value "sgp:data misc.actionbar.hud.space_negative"
execute if score #sgp.ab.hud_space_back sgp.dummy matches ..-1 run data modify storage sgp:macro actionbar_hud.function set value "sgp.misc:actionbar/hud/append_positive_space"
execute if score #sgp.ab.hud_space_back sgp.dummy matches ..-1 run data modify storage sgp:macro actionbar_hud.list set value "sgp:data misc.actionbar.hud.space_positive"
function sgp.misc:run_with_dynamic_list_index with storage sgp:macro actionbar_hud
