#> sgp.integration.tab:tick
# Refresh once after the previous mutation, then dispatch at most one LuckPerms
# user mutation. Alternating preference prevents either queue from starving.

execute if score #tab_refresh sgp.dummy matches 1 if entity @a run playerlist
execute if score #tab_refresh sgp.dummy matches 1 run scoreboard players set #tab_refresh sgp.dummy 0

execute if score #tab_init_wait sgp.dummy matches 1.. run scoreboard players remove #tab_init_wait sgp.dummy 1
execute if score #tab_init_wait sgp.dummy matches 1.. run return 0

execute if score #tab_init_done sgp.dummy matches 0 run scoreboard players set #tab_refresh sgp.dummy 1
execute if score #tab_init_done sgp.dummy matches 0 run scoreboard players set #tab_init_done sgp.dummy 1

scoreboard players remove @a[scores={sgp.tab_dirty=1..}] sgp.tab_dirty 1

execute if score #tab_queue_turn sgp.dummy matches 0 if entity @a[scores={sgp.tab_dirty=0}] run return run function sgp.integration.tab:location/update
execute if score #tab_queue_turn sgp.dummy matches 1 if entity @a[scores={sgp.kit_prefix_set=0}] run return run function sgp.integration.tab:prefix/check

execute if entity @a[scores={sgp.tab_dirty=0}] run return run function sgp.integration.tab:location/update
execute if entity @a[scores={sgp.kit_prefix_set=0}] run return run function sgp.integration.tab:prefix/check
