#> sgp.mineurs:lootdrop/restart
# @dummy
# @environment sgp.ci:lootdrop/restart
# @timeout 100
#
# Restarting with an open chest replaces the old drops; stale work cannot consume their replacements.

function sgp.ci:lootdrop/fixture
dummy @s use block ~2 ~1 ~2
await delay 2t
function sgp.mineurs:lootdrop/start
await delay 3t
assert block ~2 ~1 ~2 trapped_chest
assert block ~9 ~1 ~2 trapped_chest
dummy @s use block ~2 ~1 ~2
assert data block ~2 ~1 ~2 Items[{Slot:0b,id:"minecraft:diamond",count:64}]
dummy @s use block ~5 ~1 ~5
await delay 3t
assert block ~2 ~1 ~2 air
assert block ~9 ~1 ~2 trapped_chest
function sgp.mineurs:lootdrop/clear_existing_ones
await delay 12t
assert block ~9 ~1 ~2 air
assert not entity @e[name=lootdrop_beacon,type=text_display]
assert not entity @e[name=lootdrop_glowing_chest,type=block_display]
