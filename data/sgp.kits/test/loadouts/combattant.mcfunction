#> sgp.kits:loadouts/combattant
# @dummy
#
# Combattant stays the baseline sword-and-bow kit with its expected ammunition and food budget.

function sgp.kits:give {kit:"combattant"}

assert score @s sgp.kit_id matches 1
assert score @s sgp.reset_tags matches 1
assert entity @s[tag=sgp.combattant_voulu]
function sgp.ci:loadouts/expect_slot {slot:"hotbar.0",item:"minecraft:iron_sword"}
function sgp.ci:loadouts/expect_slot {slot:"hotbar.1",item:"minecraft:bow"}
function sgp.ci:loadouts/expect_slot {slot:"armor.chest",item:"minecraft:iron_chestplate"}
function sgp.ci:inventory/expect_count {item:"minecraft:arrow",count:16}
function sgp.ci:inventory/expect_count {item:"minecraft:golden_apple",count:2}
function sgp.ci:inventory/expect_count {item:"minecraft:cooked_beef",count:32}
