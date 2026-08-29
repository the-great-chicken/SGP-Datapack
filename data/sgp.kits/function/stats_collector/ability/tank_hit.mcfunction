#> sgp.kits:stats_collector/ability/tank_hit
#
# Executed as the Tank for a positive player_attack damage event while Bigger's
# attack-damage modifier is active.

function sgp.kits:stats_collector/ability/mark_success {kit_id:5,ability_path:"bigger"}

scoreboard players operation #ability_metric_delta sgp.dummy = #damage_received_delta sgp.dummy
function sgp.kits:stats_collector/ability/increment_score {kit_id:5,ability_path:"bigger",metric:"boosted_melee_damage"}
