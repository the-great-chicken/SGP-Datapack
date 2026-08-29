#> sgp.kits:stats_collector/ability/save_metric
# `{player_id, kit_id, ability_path, metric, amount}`

execute unless function sgp.kits:stats_collector/can_collect run return 0

scoreboard players set #ability_metric_total sgp.dummy 0

$execute store result score #ability_metric_total sgp.dummy \
    run data get storage sgp.kits:stats kits_dict.$(player_id).$(kit_id).abilities.$(ability_path).$(metric)

$scoreboard players add #ability_metric_total sgp.dummy $(amount)

$execute store result storage sgp.kits:stats kits_dict.$(player_id).$(kit_id).abilities.$(ability_path).$(metric) int 1 \
    run scoreboard players get #ability_metric_total sgp.dummy
