#> sgp.kits:loadouts/vindicateur
# @dummy
#
# Vindicateur keeps its axe/heavy-chest profile, weakness potion, food, and first-reward setup marker.

function sgp.kits:give {kit:"vindicateur"}

assert score @s sgp.kit_id matches 3
assert score @s sgp.reset_tags matches 1
assert entity @s[tag=sgp.vindicateur_voulu,tag=sgp.vindicateur_a_setup_egapp]
function sgp.ci:loadouts/expect_slot {slot:"hotbar.0",item:"minecraft:iron_axe"}
function sgp.ci:loadouts/expect_slot {slot:"armor.chest",item:"minecraft:diamond_chestplate"}
function sgp.ci:loadouts/expect_slot {slot:"hotbar.2",item:"minecraft:splash_potion"}
function sgp.ci:inventory/expect_count {item:"minecraft:splash_potion",count:1}
function sgp.ci:inventory/expect_count {item:"minecraft:cooked_beef",count:32}
