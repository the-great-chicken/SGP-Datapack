#> sgp.kits:stats_collector/pick_close_requires_start
# @dummy
# @environment sgp.ci:stats_collector
#
# Closing a life with no active pick interval fails without fabricating time or incrementing the life count.

data modify storage sgp.kits:stats kits_dict.910007.1.pick set value {total_time:25,nbr_picks:2}
execute store result storage sgp.ci:stats pick_close.result int 1 run function sgp.kits:stats_collector/save_pick_infos {id_victim:910007,kit_id_victim:1}

assert data storage sgp.ci:stats pick_close{result:0}
assert data storage sgp.kits:stats kits_dict.910007.1.pick{total_time:25,nbr_picks:2}
assert not data storage sgp.kits:stats kits_dict.910007.1.pick.last_pick
assert not data storage sgp.kits:stats kits_dict.910007.1.pick.paused_ticks
