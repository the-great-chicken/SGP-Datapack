#> sgp.kits:stats_collector/save_pick_start
# `{player_id, kit_id, pick_time: <ticks>}`

$execute unless data storage sgp.kits:stats kits_dict.$(player_id).$(kit_id).pick.total_time \
    run data modify storage sgp.kits:stats kits_dict.$(player_id).$(kit_id).pick.total_time set value 0
$execute unless data storage sgp.kits:stats kits_dict.$(player_id).$(kit_id).pick.nbr_picks \
    run data modify storage sgp.kits:stats kits_dict.$(player_id).$(kit_id).pick.nbr_picks set value 0
$data modify storage sgp.kits:stats kits_dict.$(player_id).$(kit_id).pick.last_pick set value $(pick_time)
