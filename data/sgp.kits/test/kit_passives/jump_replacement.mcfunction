#> sgp.kits:kit_passives/jump_replacement
# @dummy
# @environment sgp.ci:kit_passives/jump_replacement
#
# Changing from Pigeon to Scout lowers jump boost to the replacement kit's value.

function sgp.ci:kit_passives/fixture
function sgp.ci:kit_passives/select {kit:pigeon}
assert entity @s[nbt={active_effects:[{id:"minecraft:jump_boost",amplifier:2b}]}]
function sgp.ci:kit_passives/select {kit:eclaireur}
assert entity @s[nbt={active_effects:[{id:"minecraft:jump_boost",amplifier:1b}]}]
assert not entity @s[nbt={active_effects:[{id:"minecraft:jump_boost",amplifier:2b}]}]
function sgp.ci:kit_passives/expect_step {range:"11999..12001"}
