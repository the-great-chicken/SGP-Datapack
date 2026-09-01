#> sgp.misc:actionbar/hud/prepare_ability_fill_bar
# `{key: translation_key}`
#
# Appends the current fill glyph using the kit color selected from sgp:kits by
# hud/build.

$scoreboard players set #sgp.ab.hud_fill_width sgp.dummy $(width)
$data modify storage sgp:macro actionbar_ability_fill set value {key:"$(key)", color:white}
data modify storage sgp:macro actionbar_ability_fill.color set from storage sgp:macro actionbar_hud.kit.kit_color

function sgp.misc:actionbar/hud/append_ability_fill_bar with storage sgp:macro actionbar_ability_fill
