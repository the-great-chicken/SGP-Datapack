#> sgp.kits:loadouts/roi
# @dummy
#
# King keeps the complete golden armor/weapon identity and its expected ranged and healing reserves.

function sgp.kits:give {kit:"roi"}

assert score @s sgp.kit_id matches 6
assert score @s sgp.reset_tags matches 1
assert entity @s[tag=sgp.roi_voulu]
function sgp.ci:loadouts/expect_slot {slot:"hotbar.0",item:"minecraft:golden_sword"}
function sgp.ci:loadouts/expect_slot {slot:"hotbar.1",item:"minecraft:bow"}
function sgp.ci:loadouts/expect_slot {slot:"armor.head",item:"minecraft:golden_helmet"}
function sgp.ci:loadouts/expect_slot {slot:"armor.chest",item:"minecraft:golden_chestplate"}
function sgp.ci:inventory/expect_count {item:"minecraft:arrow",count:12}
function sgp.ci:inventory/expect_count {item:"minecraft:golden_apple",count:4}
function sgp.ci:inventory/expect_count {item:"minecraft:cooked_beef",count:32}
