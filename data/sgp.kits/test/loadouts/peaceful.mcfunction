#> sgp.kits:loadouts/peaceful
# @dummy
#
# Peaceful mode's positive path actually equips invulnerability and prevents attacks without assigning a combat kit id.

function sgp.kits:give {kit:"peaceful"}

assert score @s sgp.kit_id matches -1
assert score @s sgp.reset_tags matches 1
assert entity @s[tag=sgp.peaceful_voulu]
function sgp.ci:loadouts/expect_slot {slot:"armor.chest",item:"minecraft:netherite_chestplate"}
function sgp.ci:loadouts/expect_enchantment {slot:"armor.chest",item:"minecraft:netherite_chestplate",enchantment:"sgp.kits:invulnerable"}
assert entity @s[nbt={active_effects:[{id:"minecraft:weakness",amplifier:99b}]}]
assert chat ".*Mode Paisible.*" @s
