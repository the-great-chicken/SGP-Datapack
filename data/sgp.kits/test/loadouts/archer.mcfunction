#> sgp.kits:loadouts/archer
# @dummy
#
# Archer's direct loadout contract includes its bow package, arrow variants, armor enchantment, and Speed I passive.

function sgp.kits:give {kit:"archer"}

assert score @s sgp.kit_id matches 2
assert score @s sgp.reset_tags matches 1
assert entity @s[tag=sgp.archer_voulu]
function sgp.ci:loadouts/expect_slot {slot:"hotbar.0",item:"minecraft:wooden_sword"}
function sgp.ci:loadouts/expect_slot {slot:"hotbar.1",item:"minecraft:bow"}
function sgp.ci:loadouts/expect_enchantment {slot:"hotbar.1",item:"minecraft:bow",enchantment:"sgp.kits:splash_arrow"}
function sgp.ci:loadouts/expect_enchantment {slot:"armor.head",item:"minecraft:leather_helmet",enchantment:"sgp.kits:repulsion"}
function sgp.ci:inventory/expect_count {item:"minecraft:arrow",count:1}
function sgp.ci:inventory/expect_count {item:"minecraft:tipped_arrow",count:7}
function sgp.ci:inventory/expect_count {item:"minecraft:golden_apple",count:3}
assert entity @s[nbt={active_effects:[{id:"minecraft:speed",amplifier:0b}]}]
