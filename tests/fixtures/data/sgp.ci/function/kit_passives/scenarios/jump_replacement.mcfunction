#> sgp.ci:kit_passives/scenarios/jump_replacement

function sgp.ci:kit_passives/fixture
function sgp.ci:kit_passives/select {kit:pigeon}
assert entity @s[nbt={active_effects:[{id:"minecraft:jump_boost",amplifier:2b}]}]
function sgp.ci:kit_passives/select {kit:eclaireur}
assert entity @s[nbt={active_effects:[{id:"minecraft:jump_boost",amplifier:1b}]}]
assert not entity @s[nbt={active_effects:[{id:"minecraft:jump_boost",amplifier:2b}]}]
function sgp.ci:kit_passives/expect_step {range:"11999..12001"}
