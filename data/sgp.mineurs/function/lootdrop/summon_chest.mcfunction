#> sgp.mineurs:lootdrop/summon_chest
#
# Summons a new lootdrop chest

# Summons a chest with the loot table, updates it so that the loot table is generated,
# saves the contents to a storage, and replaces the chest with one that has the sgp.mineurs:empty
# loot table: necessary for the close detection system.
setblock ~ ~ ~ minecraft:trapped_chest{LootTable:"sgp.mineurs:lootdrop_chest"} replace

item replace block ~ ~ ~ container.0 with air

data modify storage sgp:close_detection Items set from block ~ ~ ~ Items

setblock ~ ~ ~ air
setblock ~ ~ ~ minecraft:trapped_chest{LootTable:"sgp.mineurs:empty"} replace