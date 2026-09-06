#> sgp.mineurs:lootdrop/lifecycle
# @dummy
# @environment sgp.ci:lootdrop/lifecycle
# @timeout 100
#
# Opening exposes all generated loot; closing consumes only that drop.

function sgp.ci:lootdrop/fixture
assert block ~2 ~1 ~2 trapped_chest[facing=north]
assert block ~9 ~1 ~2 trapped_chest[facing=east]
execute store result score @s sgp.dummy run data get entity @n[tag=sgp.ci.lootdrop.first,type=marker] data.Items
assert score @s sgp.dummy matches 27
dummy @s use block ~2 ~1 ~2
assert data block ~2 ~1 ~2 Items[{Slot:0b,id:"minecraft:diamond",count:64}]
await delay 3t
assert block ~2 ~1 ~2 trapped_chest
assert data block ~2 ~1 ~2 Items[{Slot:0b,id:"minecraft:diamond",count:64}]

# Replace a slot to model loot removal; the remaining inventory must not be regenerated.
item replace block ~2 ~1 ~2 container.0 with air
item replace block ~2 ~1 ~2 container.1 with minecraft:emerald 3
await delay 3t
assert not data block ~2 ~1 ~2 Items[{Slot:0b}]
assert data block ~2 ~1 ~2 Items[{Slot:1b,id:"minecraft:emerald",count:3}]

# Opening another container closes the Lootdrop through Minecraft's normal menu handling.
dummy @s use block ~5 ~1 ~5
await delay 3t
assert block ~2 ~1 ~2 air
assert block ~9 ~1 ~2 trapped_chest
execute positioned ~9 ~1 ~2 run assert entity @e[name=lootdrop_beacon,distance=..2,type=text_display]
execute positioned ~2 ~1 ~2 run assert not entity @e[name=lootdrop_beacon,distance=..2,type=text_display]
execute store success score @s sgp.dummy run trigger sgp.share_item
assert score @s sgp.dummy matches 1
