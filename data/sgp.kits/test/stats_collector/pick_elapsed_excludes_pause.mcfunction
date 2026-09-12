#> sgp.kits:stats_collector/pick_elapsed_excludes_pause
# @dummy
# @environment sgp.ci:stats_collector_guarded
#
# Closing a pick interval counts normal-play ticks exactly and excludes only the paused portion that overlaps the interval.

execute store result score #ci.stats.now sgp.dummy run time query gametime

# Forty normal-play ticks: 12 existing + 40 elapsed = 52.
scoreboard players set #stats_paused sgp.dummy 0
scoreboard players set #stats_paused_ticks sgp.dummy 100
scoreboard players operation #ci.stats.start sgp.dummy = #ci.stats.now sgp.dummy
scoreboard players remove #ci.stats.start sgp.dummy 40
data modify storage sgp.kits:stats kits_dict.910016.5.pick set value {total_time:12,nbr_picks:3,last_pick:0,paused_ticks:100}
execute store result storage sgp.kits:stats kits_dict.910016.5.pick.last_pick int 1 run scoreboard players get #ci.stats.start sgp.dummy
function sgp.kits:stats_collector/save_pick_infos {id_victim:910016,kit_id_victim:5}

# Same 40-tick interval, but the final 10 ticks are inside the current pause.
scoreboard players set #stats_paused sgp.dummy 1
scoreboard players set #stats_paused_ticks sgp.dummy 100
scoreboard players operation #stats_pause_started sgp.dummy = #ci.stats.now sgp.dummy
scoreboard players remove #stats_pause_started sgp.dummy 10
scoreboard players operation #ci.stats.start sgp.dummy = #ci.stats.now sgp.dummy
scoreboard players remove #ci.stats.start sgp.dummy 40
data modify storage sgp.kits:stats kits_dict.910017.5.pick set value {total_time:0,nbr_picks:0,last_pick:0,paused_ticks:100}
execute store result storage sgp.kits:stats kits_dict.910017.5.pick.last_pick int 1 run scoreboard players get #ci.stats.start sgp.dummy
function sgp.kits:stats_collector/save_pick_infos {id_victim:910017,kit_id_victim:5}

function sgp.ci:stats_collector/restore_runtime_globals
scoreboard players reset #ci.stats.now sgp.dummy
scoreboard players reset #ci.stats.start sgp.dummy

assert data storage sgp.kits:stats kits_dict.910016.5.pick{total_time:52,nbr_picks:4}
assert not data storage sgp.kits:stats kits_dict.910016.5.pick.last_pick
assert not data storage sgp.kits:stats kits_dict.910016.5.pick.paused_ticks
assert data storage sgp.kits:stats kits_dict.910017.5.pick{total_time:30,nbr_picks:1}
assert not data storage sgp.kits:stats kits_dict.910017.5.pick.last_pick
assert not data storage sgp.kits:stats kits_dict.910017.5.pick.paused_ticks
