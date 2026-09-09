#> sgp.ci:tnt_clicks/record

# {target}: write the complete vanilla attack record for the executing hitter.
data modify storage sgp.ci:tnt_clicks attack set value {timestamp:1L}
data modify storage sgp.ci:tnt_clicks attack.player set from entity @s UUID
$data modify entity @e[tag=sgp.ci.click_$(target),limit=1,type=interaction] attack set from storage sgp.ci:tnt_clicks attack
$assert data entity @e[tag=sgp.ci.click_$(target),limit=1,type=interaction] attack{timestamp:1L}
