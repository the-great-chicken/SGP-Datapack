#> sgp.misc:actionbar/hud/append_cooldown_frame
# `{key: translation_key, color: text_color}`
#
# Appends the selected resource-pack cooldown frame, tinted to the player's kit color.

$data modify storage sgp:actionbar_hud overlay append value {text:{translate:"$(key)", font:"sgp.kits:ability_hud", color:"$(color)", shadow_color:0}}
