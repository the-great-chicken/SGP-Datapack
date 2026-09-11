#> sgp.ci:stats_collector/save_runtime_globals
# Snapshot shared collector scores before a synchronous test temporarily overrides them.

scoreboard players set #ci.stats.schema_had sgp.dummy 0
execute if score #stats_schema_version sgp.dummy = #stats_schema_version sgp.dummy run scoreboard players set #ci.stats.schema_had sgp.dummy 1
execute if score #ci.stats.schema_had sgp.dummy matches 1 run scoreboard players operation #ci.stats.schema_value sgp.dummy = #stats_schema_version sgp.dummy

scoreboard players set #ci.stats.paused_had sgp.dummy 0
execute if score #stats_paused sgp.dummy = #stats_paused sgp.dummy run scoreboard players set #ci.stats.paused_had sgp.dummy 1
execute if score #ci.stats.paused_had sgp.dummy matches 1 run scoreboard players operation #ci.stats.paused_value sgp.dummy = #stats_paused sgp.dummy

scoreboard players set #ci.stats.paused_ticks_had sgp.dummy 0
execute if score #stats_paused_ticks sgp.dummy = #stats_paused_ticks sgp.dummy run scoreboard players set #ci.stats.paused_ticks_had sgp.dummy 1
execute if score #ci.stats.paused_ticks_had sgp.dummy matches 1 run scoreboard players operation #ci.stats.paused_ticks_value sgp.dummy = #stats_paused_ticks sgp.dummy

scoreboard players set #ci.stats.pause_started_had sgp.dummy 0
execute if score #stats_pause_started sgp.dummy = #stats_pause_started sgp.dummy run scoreboard players set #ci.stats.pause_started_had sgp.dummy 1
execute if score #ci.stats.pause_started_had sgp.dummy matches 1 run scoreboard players operation #ci.stats.pause_started_value sgp.dummy = #stats_pause_started sgp.dummy

scoreboard players set #ci.stats.elo_display_had sgp.dummy 0
execute if score #elo_display_available sgp.dummy = #elo_display_available sgp.dummy run scoreboard players set #ci.stats.elo_display_had sgp.dummy 1
execute if score #ci.stats.elo_display_had sgp.dummy matches 1 run scoreboard players operation #ci.stats.elo_display_value sgp.dummy = #elo_display_available sgp.dummy
