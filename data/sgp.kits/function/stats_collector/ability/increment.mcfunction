#> sgp.kits:stats_collector/ability/increment
# `{kit_id: int, ability_path: string, metric: string, amount: int}`

$scoreboard players set #ability_metric_delta sgp.dummy $(amount)
$function sgp.kits:stats_collector/ability/increment_score {kit_id:$(kit_id),ability_path:"$(ability_path)",metric:"$(metric)"}
