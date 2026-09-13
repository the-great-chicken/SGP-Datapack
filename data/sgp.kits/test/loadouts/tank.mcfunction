#> sgp.kits:loadouts/tank
# @dummy
#
# Tank keeps its heavy armor, shield, turtle arrows/potions, and healing reserve.

function sgp.kits:give {kit:"tank"}

assert score @s sgp.kit_id matches 5
assert score @s sgp.reset_tags matches 1
assert entity @s[tag=sgp.tank_voulu]
function sgp.ci:loadouts/expect_slot {slot:"hotbar.0",item:"minecraft:wooden_sword"}
function sgp.ci:loadouts/expect_slot {slot:"armor.head",item:"minecraft:diamond_helmet"}
function sgp.ci:loadouts/expect_slot {slot:"armor.feet",item:"minecraft:diamond_boots"}
function sgp.ci:loadouts/expect_slot {slot:"weapon.offhand",item:"minecraft:shield"}
function sgp.ci:inventory/expect_count {item:"minecraft:tipped_arrow",count:5}
function sgp.ci:inventory/expect_count {item:"minecraft:potion",count:3}
function sgp.ci:inventory/expect_count {item:"minecraft:golden_apple",count:3}
