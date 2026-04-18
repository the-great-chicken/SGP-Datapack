#> sgp.mineurs:lootdrop/close_detection/tick/init
# 
# Checks if the chest was closed by looking if the LootTable is present on it.

execute as @e[tag=sgp.opened_chest,distance=..7,limit=1,type=marker] at @s \
    if block ~ ~ ~ trapped_chest \
    if data block ~ ~ ~ LootTable \
    run function sgp.mineurs:lootdrop/close_detection/tick/closed

execute unless entity @s[tag=sgp.container_open] run return 0

advancement revoke @s only sgp.mineurs:tick