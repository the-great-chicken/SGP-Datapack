#> sgp.misc:actionbar/hud/prepare_cooldown_frame
# `{key: translation_key}`
#
# Prepares the selected cooldown-frame glyph using the kit color chosen by
# hud/build, then appends it to the HUD overlay.

$scoreboard players set #sgp.ab.hud_fill_width sgp.dummy $(width)
$data modify storage sgp:macro actionbar_cooldown_frame set value {key:"$(key)", color:white}
data modify storage sgp:macro actionbar_cooldown_frame.color set from storage sgp:macro actionbar_hud.kit.kit_color

function sgp.misc:actionbar/hud/append_cooldown_frame with storage sgp:macro actionbar_cooldown_frame
