#> sgp.kits:stats_collector/entrypoints/kit_pick
# @dummy
# @environment sgp.ci:stats_collector_guarded
#
# Starting a real kit pick captures the current game tick and paused-tick baseline, while paused collection creates no new pick.

scoreboard players set #stats_schema_version sgp.dummy 7
scoreboard players set #stats_paused sgp.dummy 0
scoreboard players set #stats_paused_ticks sgp.dummy 123
scoreboard players set @s sgp.id 910021
scoreboard players set @s sgp.kit_id 6
execute store result score #ci.stats.pick_expected sgp.dummy run time query gametime
function sgp.kits:stats_collector/collect_kit_pick_infos
execute store result score #ci.stats.pick_actual sgp.dummy run data get storage sgp.kits:stats kits_dict.910021.6.pick.last_pick

assert score #ci.stats.pick_actual sgp.dummy = #ci.stats.pick_expected sgp.dummy
assert data storage sgp.kits:stats kits_dict.910021.6.pick{total_time:0,nbr_picks:0,paused_ticks:123}

scoreboard players set #stats_paused sgp.dummy 1
scoreboard players set @s sgp.kit_id 7
function sgp.kits:stats_collector/collect_kit_pick_infos
assert not data storage sgp.kits:stats kits_dict.910021.7.pick

scoreboard players reset #ci.stats.pick_expected sgp.dummy
scoreboard players reset #ci.stats.pick_actual sgp.dummy
