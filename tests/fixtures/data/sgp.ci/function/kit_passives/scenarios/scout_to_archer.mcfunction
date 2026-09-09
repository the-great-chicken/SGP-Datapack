#> sgp.ci:kit_passives/scenarios/scout_to_archer

function sgp.ci:kit_passives/fixture
function sgp.ci:kit_passives/select {kit:eclaireur}
function sgp.ci:kit_passives/expect_speed {range:"1599..1601"}
function sgp.ci:kit_passives/expect_step {range:"11999..12001"}
assert entity @s[nbt={active_effects:[{id:"minecraft:jump_boost",amplifier:1b}]}]
function sgp.ci:kit_passives/select {kit:archer}
function sgp.ci:kit_passives/expect_speed {range:"1199..1201"}
function sgp.ci:kit_passives/expect_step {range:"5999..6001"}
assert score @s sgp.kit_id matches 2
assert not entity @s[nbt={active_effects:[{id:"minecraft:jump_boost"}]}]
