#> sgp.kits:loadouts/cancer
# @dummy
#
# Cancer retains its unusual melee weapon plus the full arrow, potion, and minecart payload.

function sgp.kits:give {kit:"cancer"}

assert score @s sgp.kit_id matches 10
assert score @s sgp.reset_tags matches 1
assert entity @s[tag=sgp.cancer_voulu]
function sgp.ci:loadouts/expect_slot {slot:"hotbar.0",item:"minecraft:stick"}
function sgp.ci:loadouts/expect_slot {slot:"hotbar.1",item:"minecraft:bow"}
function sgp.ci:loadouts/expect_slot {slot:"armor.chest",item:"minecraft:golden_chestplate"}
function sgp.ci:inventory/expect_count {item:"minecraft:tipped_arrow",count:10}
function sgp.ci:inventory/expect_count {item:"minecraft:splash_potion",count:6}
function sgp.ci:inventory/expect_count {item:"minecraft:tnt_minecart",count:2}
function sgp.ci:inventory/expect_count {item:"minecraft:golden_apple",count:4}
