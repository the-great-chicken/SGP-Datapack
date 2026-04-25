#> sgp.mineurs:lootdrop/close_detection/on_open
#
# Executed as the lootdrop's marker, at the chest position
# Fill the chest with items, remove the glow

tag @s add sgp.opened_chest
kill @n[name=lootdrop_glowing_chest,distance=..2,type=block_display]
data modify block ~ ~ ~ LootTable set value "sgp.misc:empty"
data modify block ~ ~ ~ Items set from entity @s data.Items
function #bs.schedule:schedule {run:"execute as @e[tag=sgp.opened_chest,limit=1,type=marker] at @s if block ~ ~ ~ trapped_chest run function sgp.mineurs:lootdrop/close_detection/schedule",with:{id:"close_detection",time:1,unit:"t"}}