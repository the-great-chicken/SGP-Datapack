#> sgp.ci:stats_collector/restore_runtime_globals
# Restore the snapshot made by save_runtime_globals. Safe to call repeatedly.

execute if score #ci.stats.schema_had sgp.dummy matches 1 run scoreboard players operation #stats_schema_version sgp.dummy = #ci.stats.schema_value sgp.dummy
execute unless score #ci.stats.schema_had sgp.dummy matches 1 run scoreboard players reset #stats_schema_version sgp.dummy

execute if score #ci.stats.paused_had sgp.dummy matches 1 run scoreboard players operation #stats_paused sgp.dummy = #ci.stats.paused_value sgp.dummy
execute unless score #ci.stats.paused_had sgp.dummy matches 1 run scoreboard players reset #stats_paused sgp.dummy

execute if score #ci.stats.paused_ticks_had sgp.dummy matches 1 run scoreboard players operation #stats_paused_ticks sgp.dummy = #ci.stats.paused_ticks_value sgp.dummy
execute unless score #ci.stats.paused_ticks_had sgp.dummy matches 1 run scoreboard players reset #stats_paused_ticks sgp.dummy

execute if score #ci.stats.pause_started_had sgp.dummy matches 1 run scoreboard players operation #stats_pause_started sgp.dummy = #ci.stats.pause_started_value sgp.dummy
execute unless score #ci.stats.pause_started_had sgp.dummy matches 1 run scoreboard players reset #stats_pause_started sgp.dummy

execute if score #ci.stats.elo_display_had sgp.dummy matches 1 run scoreboard players operation #elo_display_available sgp.dummy = #ci.stats.elo_display_value sgp.dummy
execute unless score #ci.stats.elo_display_had sgp.dummy matches 1 run scoreboard players reset #elo_display_available sgp.dummy
