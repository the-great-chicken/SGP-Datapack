#> sgp.kits:loadouts/eclaireur
# @dummy
#
# Scout's mobility loadout includes the crossbow/spyglass package and both movement passives.

function sgp.kits:give {kit:"eclaireur"}

assert score @s sgp.kit_id matches 7
assert score @s sgp.reset_tags matches 1
assert entity @s[tag=sgp.eclaireur_voulu]
function sgp.ci:loadouts/expect_slot {slot:"hotbar.0",item:"minecraft:stone_sword"}
function sgp.ci:loadouts/expect_slot {slot:"hotbar.1",item:"minecraft:crossbow"}
function sgp.ci:loadouts/expect_slot {slot:"hotbar.6",item:"minecraft:spyglass"}
function sgp.ci:loadouts/expect_slot {slot:"armor.feet",item:"minecraft:diamond_boots"}
function sgp.ci:inventory/expect_count {item:"minecraft:arrow",count:3}
function sgp.ci:inventory/expect_count {item:"minecraft:golden_apple",count:6}
assert entity @s[nbt={active_effects:[{id:"minecraft:speed",amplifier:2b}]}]
assert entity @s[nbt={active_effects:[{id:"minecraft:jump_boost",amplifier:1b}]}]
