#> sgp.ci:cooldown_hud/assert_overlay
# `{kit_icon: string, kit_color: color, frame: int}`
#
# Assert the components consumed by the resource pack, without depending on cache scores or spacing glyphs.

$execute store result score @s sgp.dummy if data storage sgp:actionbar_hud overlay[{text:{translate:"sgp.kits.ability_bar.$(frame)",font:"sgp.kits:ability_hud",color:"$(kit_color)"}}]
assert score @s sgp.dummy matches 1
$execute store result score @s sgp.dummy if data storage sgp:actionbar_hud overlay[{text:{text:"$(kit_icon)",font:"sgp.kits:ability_hud",color:"$(kit_color)"}}]
assert score @s sgp.dummy matches 1
