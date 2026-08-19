#> sgp.kits:stats_collector/save_pick_start
# `{player_id, kit_id, pick_time: <ticks>}`

$data modify storage sgp.kits:stats kits_dict.$(player_id).$(kit_id).pick.last_pick set value $(pick_time)