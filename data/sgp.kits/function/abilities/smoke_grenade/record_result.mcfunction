#> sgp.kits:abilities/smoke_grenade/record_result
#
# Executed as the grenade owner. #smoke_affected was counted at landing.

execute unless score #smoke_affected sgp.dummy matches 1.. run return 0

function sgp.kits:stats_collector/ability/mark_success {kit_id:7,ability_path:"smoke_grenade"}
scoreboard players operation #ability_metric_delta sgp.dummy = #smoke_affected sgp.dummy
function sgp.kits:stats_collector/ability/increment_score {kit_id:7,ability_path:"smoke_grenade",metric:"affected_players"}
