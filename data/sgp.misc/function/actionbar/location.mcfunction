#> sgp.misc:actionbar/location
# `{text: json_text_component, duration: int}`
#
# Shows or refreshes the location actionbar segment.

$data modify storage dah:actbar new set value {id:"sgp:location",order:90,text:$(text)}
function dah.actbar_mixer:new/update_id
$scoreboard players set @s sgp.ab.location $(duration)
