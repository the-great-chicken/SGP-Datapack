#> sgp.misc:actionbar/hud/append_ability_fill_bar
# `{key: translation_key, color: text_color}`
#
# Appends the current filled cooldown glyph, tinted to the player's kit color.

$data modify storage sgp:actionbar_hud overlay append value {text:{translate:"$(key)",font:"sgp.kits:ability_hud",color:"$(color)",shadow:false}}
