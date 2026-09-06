#> sgp.mineurs:lootdrop/lifecycle
# @dummy
# @environment sgp.ci:lootdrop/lifecycle
#
# Starting creates both drops with all generated loot and their configured facing; stopping removes them.
# Actual menu timing is covered by playtesting because dummy interactions defer loot advancements.

function sgp.ci:lootdrop/fixture
assert block ~2 ~1 ~2 trapped_chest[facing=north]
assert block ~9 ~1 ~2 trapped_chest[facing=east]
execute store result score @s sgp.dummy run data get entity @n[tag=sgp.ci.lootdrop.first,type=marker] data.Items
assert score @s sgp.dummy matches 27
assert data entity @n[tag=sgp.ci.lootdrop.first,type=marker] data.Items[{Slot:0b,id:"minecraft:diamond",count:64}]
execute store result score @s sgp.dummy run data get entity @n[tag=sgp.ci.lootdrop.second,type=marker] data.Items
assert score @s sgp.dummy matches 27
execute positioned ~2 ~1 ~2 run assert entity @e[name=lootdrop_beacon,distance=..2,type=text_display]
execute positioned ~9 ~1 ~2 run assert entity @e[name=lootdrop_beacon,distance=..2,type=text_display]
execute positioned ~2 ~1 ~2 run assert entity @e[name=lootdrop_glowing_chest,distance=..2,type=block_display]
await delay 12t
assert block ~2 ~1 ~2 trapped_chest
assert block ~9 ~1 ~2 trapped_chest
function sgp.mineurs:lootdrop/clear_existing_ones
await delay 12t
assert block ~2 ~1 ~2 air
assert block ~9 ~1 ~2 air
assert not entity @e[name=lootdrop_beacon,type=text_display]
assert not entity @e[name=lootdrop_glowing_chest,type=block_display]
