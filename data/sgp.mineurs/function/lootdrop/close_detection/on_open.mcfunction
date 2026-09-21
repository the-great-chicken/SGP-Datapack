#> sgp.mineurs:lootdrop/close_detection/on_open
#
# Executed as the lootdrop's marker, at the chest position
# Fill the chest with items, remove the glow

tag @s add sgp.opened_chest
kill @n[name=lootdrop_glowing_chest,distance=..2,type=block_display]
data modify block ~ ~ ~ LootTable set value "sgp.misc:empty"
data modify block ~ ~ ~ Items set from entity @s data.Items
# From here minecraft:execute_repeating_functions re-applies the empty loot table to every
# lootdrop chest each tick (before the players tick), so the open menu keeps consuming it and
# tick/init can tell an open chest from a closed one. This used to also start a Bookshelf
# schedule chain that re-scheduled itself once per remaining chest per callback and multiplied
# every tick (21 700 callbacks in 41 ticks in a real capture, the server at 6.8 TPS).