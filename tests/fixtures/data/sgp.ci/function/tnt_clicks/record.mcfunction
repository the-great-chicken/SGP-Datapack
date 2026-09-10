#> sgp.ci:tnt_clicks/record
# `{target: a|b}`
#
# Write a complete vanilla attack interaction record for the selected TNT listener and current hitter.

data modify storage sgp.ci:tnt_clicks attack set value {timestamp:1L}
data modify storage sgp.ci:tnt_clicks attack.player set from entity @s UUID
$data modify entity @e[tag=sgp.ci.click_$(target),limit=1,type=interaction] attack set from storage sgp.ci:tnt_clicks attack
$assert data entity @e[tag=sgp.ci.click_$(target),limit=1,type=interaction] attack{timestamp:1L}
