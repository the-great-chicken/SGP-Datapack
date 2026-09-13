#> sgp.kits:loadouts/alchimiste
# @dummy
#
# Alchimiste's loadout keeps its potion-heavy identity and alchemical-protection armor.

function sgp.kits:give {kit:"alchimiste"}

assert score @s sgp.kit_id matches 8
assert score @s sgp.reset_tags matches 1
assert entity @s[tag=sgp.alchimiste_voulu]
function sgp.ci:loadouts/expect_slot {slot:"hotbar.0",item:"minecraft:stone_sword"}
function sgp.ci:loadouts/expect_slot {slot:"armor.chest",item:"minecraft:chainmail_chestplate"}
function sgp.ci:loadouts/expect_enchantment {slot:"armor.chest",item:"minecraft:chainmail_chestplate",enchantment:"sgp.kits:alchemical_protection"}
function sgp.ci:loadouts/expect_slot {slot:"hotbar.4",item:"minecraft:milk_bucket"}
function sgp.ci:inventory/expect_count {item:"minecraft:splash_potion",count:19}
function sgp.ci:inventory/expect_count {item:"minecraft:baked_potato",count:64}
