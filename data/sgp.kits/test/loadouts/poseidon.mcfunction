#> sgp.kits:loadouts/poseidon
# @dummy
#
# Poseidon receives one Riptide trident plus its ranged trident reserve, aquatic boots, food, and aquatic passives.

function sgp.kits:give {kit:"poseidon"}

assert score @s sgp.kit_id matches 11
assert score @s sgp.reset_tags matches 1
assert entity @s[tag=sgp.poseidon_voulu,tag=sgp.poseidon_a_setup_egapp]
function sgp.ci:loadouts/expect_enchantment_count {item:"minecraft:trident",enchantment:"minecraft:riptide",count:1}
function sgp.ci:loadouts/expect_enchantment_count {item:"minecraft:trident",enchantment:"sgp.kits:kd_projectile_scaling",count:16}
function sgp.ci:loadouts/expect_enchantment {slot:"armor.feet",item:"minecraft:chainmail_boots",enchantment:"sgp.kits:depth_strider_boosted"}
function sgp.ci:loadouts/expect_slot {slot:"hotbar.1",item:"minecraft:cooked_cod"}
function sgp.ci:inventory/expect_count {item:"minecraft:trident",count:17}
function sgp.ci:inventory/expect_count {item:"minecraft:cooked_cod",count:64}
assert entity @s[nbt={active_effects:[{id:"minecraft:slowness",amplifier:3b}]}]
assert entity @s[nbt={active_effects:[{id:"minecraft:resistance",amplifier:2b}]}]
assert entity @s[nbt={active_effects:[{id:"minecraft:hunger",amplifier:3b}]}]
assert entity @s[nbt={active_effects:[{id:"minecraft:conduit_power"}]}]
