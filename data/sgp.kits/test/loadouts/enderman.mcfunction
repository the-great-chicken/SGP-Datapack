#> sgp.kits:loadouts/enderman
# @dummy
#
# Enderman keeps its teleport consumables, water-vulnerable headgear, and regeneration passive.

function sgp.kits:give {kit:"enderman"}

assert score @s sgp.kit_id matches 9
assert score @s sgp.reset_tags matches 1
assert entity @s[tag=sgp.enderman_voulu]
function sgp.ci:loadouts/expect_slot {slot:"hotbar.0",item:"minecraft:diamond_sword"}
function sgp.ci:loadouts/expect_slot {slot:"hotbar.1",item:"minecraft:ender_pearl"}
function sgp.ci:loadouts/expect_enchantment {slot:"armor.head",item:"minecraft:player_head",enchantment:"sgp.kits:water_damage"}
function sgp.ci:inventory/expect_count {item:"minecraft:ender_pearl",count:8}
function sgp.ci:inventory/expect_count {item:"minecraft:splash_potion",count:1}
function sgp.ci:inventory/expect_count {item:"minecraft:chorus_fruit",count:64}
assert entity @s[nbt={active_effects:[{id:"minecraft:regeneration"}]}]
