#> sgp.mineurs:lootdrop/tick_reapply
# @dummy
# @environment sgp.ci:lootdrop/tick_reapply
#
# The per-tick loop in minecraft:execute_repeating_functions puts the empty loot table back on
# every registered lootdrop chest, which is what the close detection relies on; stopping the
# event removes the chests, so nothing is re-applied afterwards.
function sgp.ci:lootdrop/fixture
data remove block ~2 ~1 ~2 LootTable
await delay 2t
assert data block ~2 ~1 ~2 {LootTable:"sgp.misc:empty"}
function sgp.mineurs:lootdrop/clear_existing_ones
await delay 2t
assert block ~2 ~1 ~2 air
