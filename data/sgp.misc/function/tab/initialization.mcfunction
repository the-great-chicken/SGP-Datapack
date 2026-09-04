#> sgp.misc:tab/initialization
# Initialize shared runtime state for tab-list prefixes and location suffixes.

function sgp.misc:tab/luckperms/initialization

execute unless score #tab_location_serial sgp.dummy matches -2147483648..2147483647 run scoreboard players set #tab_location_serial sgp.dummy 1000000
scoreboard players set #tab_queue_turn sgp.dummy 0
scoreboard players set #tab_refresh sgp.dummy 0
scoreboard players set #tab_init_wait sgp.dummy 0
scoreboard players set #tab_init_done sgp.dummy 0

execute as @a run function sgp.misc:tab/player_initialization
