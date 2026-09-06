#> sgp.mineurs:lootdrop/shared_chest
# @dummy
# @environment sgp.ci:lootdrop/shared_chest
# @timeout 100
#
# A second viewer shares remaining loot, and the drop survives until both viewers close it.

function sgp.ci:lootdrop/fixture
dummy LootViewer spawn
tp LootViewer ~3.5 ~1 ~4.5
gamemode creative LootViewer
tag LootViewer add sgp.in_game
dummy @s use block ~2 ~1 ~2
item replace block ~2 ~1 ~2 container.0 with minecraft:emerald 3
dummy LootViewer use block ~2 ~1 ~2
assert data block ~2 ~1 ~2 Items[{Slot:0b,id:"minecraft:emerald",count:3}]
await delay 3t
assert block ~2 ~1 ~2 trapped_chest
assert data block ~2 ~1 ~2 Items[{Slot:0b,id:"minecraft:emerald",count:3}]
dummy @s use block ~5 ~1 ~5
await delay 3t
assert block ~2 ~1 ~2 trapped_chest
assert data block ~2 ~1 ~2 Items[{Slot:0b,id:"minecraft:emerald",count:3}]
dummy LootViewer use block ~5 ~1 ~5
await delay 3t
assert block ~2 ~1 ~2 air
assert block ~9 ~1 ~2 trapped_chest
