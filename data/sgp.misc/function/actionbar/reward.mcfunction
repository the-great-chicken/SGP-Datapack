#> sgp.misc:actionbar/reward
# `{text: json_text_component, duration: int}`
#
# Shows or refreshes the kill-reward actionbar segment.

$data modify storage dah:actbar new set value {id:"sgp:reward",order:100,text:$(text)}
function dah.actbar_mixer:new/update_id
$scoreboard players set @s sgp.ab.reward $(duration)
