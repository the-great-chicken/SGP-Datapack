#> sgp.misc:actionbar/location
# `{lieu: string, text: json_text_component}`
#
# Adds or refreshes one location actionbar segment.
# Each location owns its own Actionbar Mixer id so overlapping locations can
# coexist and be removed independently.

$data modify storage dah:actbar new set value {id:"sgp:location_$(lieu)", order:90, text:$(text)}
function dah.actbar_mixer:new/update_id
