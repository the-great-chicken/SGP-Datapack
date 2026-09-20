#> dah.actbar_mixer:z_private/display/render
#
# SGP HUD overlay override for Actionbar Mixer v1.4.
# Keep Mixer's normal rendering semantics, but prepend the zero-net-width SGP HUD.

function sgp.misc:actionbar/hud/build

# The HUD can exist without any normal Mixer segments, so do not use Mixer's normal empty-content early return until after checking the overlay.
execute unless data storage dah:actbar data[0].content[0] if data storage sgp:actionbar_hud overlay[0] run return run title @s actionbar {nbt:"overlay[].text",storage:"sgp:actionbar_hud",interpret:true,separator:"",bold:false}
execute unless data storage dah:actbar data[0].content[0] run return run title @s actionbar ""

# Actionbar Mixer v1.4 renderer. The neutral wrapper around the first segment keeps sibling styles independent without storing a persistent ROOT_RESET row.
data modify storage dah:actbar parsing set value []
data modify storage dah:actbar parsing append from storage dah:actbar data[0].content[].text

data modify storage dah:actbar parsing prepend value {extra:[""],text:""}
data modify storage dah:actbar parsing[0].extra[0] set from storage dah:actbar parsing[1]
data remove storage dah:actbar parsing[1]
data modify storage dah:actbar display set value {nbt:"parsing[]",storage:"dah:actbar",interpret:true,separator:""}
data modify storage dah:actbar display.separator set from storage dah:actbar data[0].separator

execute if data storage sgp:actionbar_hud overlay[0] run return run title @s actionbar [{nbt:"overlay[].text",storage:"sgp:actionbar_hud",interpret:true,separator:"",bold:false},{storage:"dah:actbar",nbt:"display",interpret:true,font:"minecraft:default"}]
title @s actionbar {storage:"dah:actbar",nbt:"display",interpret:true}
