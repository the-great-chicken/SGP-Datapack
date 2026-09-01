#> sgp.kits:stats_collector/ability/increment_score
# `{kit_id: int, ability_path: string, metric: string}`
#
# Adds #ability_metric_delta to one stored ability metric for the executing player.

$data modify storage sgp:macro stats.current_ability_metric set value {player_id:0,kit_id:$(kit_id),ability_path:"$(ability_path)",metric:"$(metric)",amount:0}

execute store result storage sgp:macro stats.current_ability_metric.player_id int 1 \
    run scoreboard players get @s sgp.id

execute store result storage sgp:macro stats.current_ability_metric.amount int 1 \
    run scoreboard players get #ability_metric_delta sgp.dummy

function sgp.kits:stats_collector/ability/save_metric with storage sgp:macro stats.current_ability_metric
