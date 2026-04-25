#> sgp.mineurs:lootdrop/close_detection/init
#
# Gets triggered when a player opens a lootdrop.
# Schedules the schedule function, generates the loot,...
# The close detection system was made from the datapack created by Highmore:
# https://discord.com/channels/154777837382008833/157097006500806656/1237254066480877619 

advancement revoke @s only sgp.mineurs:open_chest

execute unless entity @s[tag=sgp.peaceful] \
    as @n[tag=sgp.marker,name="Lootdrop",distance=..7,type=marker] at @s \
        run function sgp.mineurs:lootdrop/close_detection/on_open

execute unless entity @s[tag=sgp.peaceful] run tag @s add sgp.container_open

# The tick advancement below helps us run a function in the subtick after the LootTable is generated within the subtick.
advancement revoke @s only sgp.mineurs:tick