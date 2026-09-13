#> sgp.mineurs:lootdrop/production_loot
#
# Minecraft loads and evaluates the unchanged production table as well as the deterministic lifecycle fixture.

setblock ~ ~1 ~ chest
execute store success score #ci.lootdrop.production sgp.dummy run loot insert ~ ~1 ~ loot sgp.ci:production/lootdrop_chest
assert score #ci.lootdrop.production sgp.dummy matches 1
assert data block ~ ~1 ~ Items[0]
