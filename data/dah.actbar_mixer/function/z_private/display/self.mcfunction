#> dah.actbar_mixer:z_private/display/self
#
# SGP HUD overlay override.
# This keeps Actionbar Mixer responsible for the normal actionbar content, but
# prepends a zero-net-width HUD overlay before that content is rendered.

function sgp.misc:actionbar/hud/build

scoreboard players set #test dah.actbar.calc 1

execute if entity @s[tag=dah.actbar.pause] run return fail

data modify storage dah:actbar display_content set from storage dah:actbar data[0].content
data remove storage dah:actbar display_content[{id:"dah_actbar:ROOT_RESET"}]

function dah.actbar_mixer:z_private/display/title with storage dah:actbar data[0]
