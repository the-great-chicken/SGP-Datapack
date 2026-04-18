#> sgp.mineurs:lootdrop/summon_chest
#
# Summons a new lootdrop chest

# Summons a chest with the loot table, updates it so that the loot table is generated,
# saves the contents to a storage, and replaces the chest with one that has the sgp.misc:empty
# loot table: necessary for the close detection system.
setblock ~ ~ ~ minecraft:trapped_chest{LootTable:"sgp.mineurs:lootdrop_chest"} replace

item replace block ~ ~ ~ container.0 with air

data modify storage sgp:close_detection Items set from block ~ ~ ~ Items

setblock ~ ~ ~ air
setblock ~ ~ ~ minecraft:trapped_chest{LootTable:"sgp.misc:empty"} replace

# Normalize y level position
summon marker ~ ~ ~ {Tags:["sgp.y_anchor"]}
data modify entity @e[tag=sgp.y_anchor,limit=1,distance=..1,type=marker] Pos[1] set from entity @e[type=marker,tag=sgp.marker,name=pvp_arena,limit=1] Pos[1]
execute at @e[tag=sgp.y_anchor,limit=1,type=marker] run function sgp.mineurs:lootdrop/summon_beacon with entity @e[type=marker,tag=sgp.marker,name=pvp_arena,limit=1] data
kill @e[tag=sgp.y_anchor,limit=1,type=marker]