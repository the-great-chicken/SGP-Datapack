#> sgp.mineurs:lootdrop/close_detection/init
#
# Gets triggered when a player opens a lootdrop.
# Schedules the schedule function, generates the loot,...
# The close detection system was made from the datapack created by Highmore:
# https://discord.com/channels/154777837382008833/157097006500806656/1237254066480877619 

advancement revoke @s only sgp.mineurs:open_chest

execute as @n[tag=sgp.marker,name="Lootdrop",distance=..7,type=marker] run tag @s add sgp.opened_chest

execute as @e[tag=sgp.opened_chest,distance=..7,limit=1,type=marker] at @s \
    if block ~ ~ ~ trapped_chest \
        run data modify block ~ ~ ~ LootTable set value "sgp.misc:empty"

tag @s add sgp.container_open

# Summoning the items in the chest
execute unless entity @s[tag=sgp.peaceful] \
    as @e[tag=sgp.opened_chest,distance=..7,limit=1,type=marker] at @s \
        if block ~ ~ ~ trapped_chest \
            run data modify block ~ ~ ~ Items set from storage sgp:close_detection Items

function #bs.schedule:schedule {run:"execute as @e[tag=sgp.opened_chest,limit=1,type=marker] at @s if block ~ ~ ~ trapped_chest run function sgp.mineurs:lootdrop/close_detection/schedule",with:{id:"close_detection",time:1,unit:"t"}}


# The tick advancement below helps us run a function in the subtick after the LootTable is generated within the subtick.
advancement revoke @s only sgp.mineurs:tick