#> sgp.integration.tab:initialization
# Initialize shared runtime state for tab-list prefixes and location suffixes.

scoreboard objectives add sgp.tab_dirty dummy
scoreboard objectives add sgp.tab_candidate dummy
scoreboard objectives add sgp.tab_applied dummy
scoreboard objectives add sgp.kit_prefix_set dummy

function sgp.integration.tab:luckperms/initialization

scoreboard players set #tab_queue_turn sgp.dummy 0
scoreboard players set #tab_refresh sgp.dummy 0
scoreboard players set #tab_init_wait sgp.dummy 0
scoreboard players set #tab_init_done sgp.dummy 0

execute as @a run function sgp.integration.tab:player_initialization
