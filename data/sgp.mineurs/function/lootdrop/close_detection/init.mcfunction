#> sgp.mineurs:lootdrop/close_detection/init
#
# Gets triggered when a player opens a lootdrop.
# Schedules the schedule function, generates the loot,...
# The close detection system was made from the datapack created by Highmore:
# https://discord.com/channels/154777837382008833/157097006500806656/1237254066480877619 

advancement revoke @s only sgp.mineurs:open_chest

execute as @e[type=marker,tag=sgp.marker,name="Lootdrop"] at @s \
    if block ~ ~ ~ trapped_chest \
        run data modify block ~ ~ ~ LootTable set value "sgp.mineurs:empty"

# Tagging player for schedule function to keep running.
tag @s add sgp.container_open

# Summoning the items in the chest
execute as @e[type=marker,tag=sgp.marker,name="Lootdrop"] at @s \
    if block ~ ~ ~ trapped_chest \
        run data modify block ~ ~ ~ Items set from storage sgp:close_detection Items

function #bs.schedule:schedule {with:{id:"close_detection",command:"execute as @e[type=marker,tag=sgp.marker,name=\"Lootdrop\"] at @s if block ~ ~ ~ trapped_chest run function sgp.mineurs:lootdrop/close_detection/schedule",time:1,unit:"t"}}


# The tick advancement below helps us run a function in the subtick after the LootTable is generated within the subtick.
advancement revoke @s only sgp.mineurs:tick