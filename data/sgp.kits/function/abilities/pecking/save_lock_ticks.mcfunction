#> sgp.kits:abilities/pecking/save_lock_ticks

scoreboard players operation #ability_metric_delta sgp.dummy = @s sgp.peck_lock_ticks
function sgp.kits:stats_collector/ability/increment_score {kit_id:0,ability_path:"pecking",metric:"target_lock_ticks"}

scoreboard players reset @s sgp.peck_lock_ticks
tag @s remove sgp.stats_pecking_active
