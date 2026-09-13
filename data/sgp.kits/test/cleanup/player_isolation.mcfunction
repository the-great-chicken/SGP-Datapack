#> sgp.kits:cleanup/player_isolation
# @dummy
# @environment sgp.ci:kit_cleanup/player_isolation
#
# Clearing one player leaves another player's kit, equipment, effects, and step height intact.

function sgp.ci:kit_cleanup/loadout
dummy CleanupPeer spawn
execute as CleanupPeer run function sgp.ci:kit_cleanup/loadout
function sgp.kits:clear
function sgp.ci:kit_cleanup/expect_empty
assert score CleanupPeer sgp.kit_id matches 5
assert data entity CleanupPeer Inventory[0]
assert data entity CleanupPeer equipment.head{id:"minecraft:diamond_helmet"}
assert data entity CleanupPeer equipment.offhand{id:"minecraft:shield"}
assert entity @a[name=CleanupPeer,nbt={active_effects:[{id:"minecraft:speed"},{id:"minecraft:jump_boost"},{id:"minecraft:fire_resistance"}]}]
execute as CleanupPeer run function sgp.ci:kit_cleanup/expect_step {range:"9999..10001"}
