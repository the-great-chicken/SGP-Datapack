#> sgp.misc:actionbar/location
# `{text: json_text_component, width: int}`
#
# Shows or refreshes the location actionbar segment and declares its
# approximate normal-actionbar width for the fixed HUD overlay compensation.
# The segment stays visible until no location contains the player anymore.

$data modify storage dah:actbar new set value {id:"sgp:location", order:90, text:$(text)}
function dah.actbar_mixer:new/update_id
scoreboard players set @s sgp.ab.location 1
$scoreboard players set @s sgp.ab.location_width $(width)
