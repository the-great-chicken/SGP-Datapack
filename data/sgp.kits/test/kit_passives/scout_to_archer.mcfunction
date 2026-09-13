#> sgp.kits:kit_passives/scout_to_archer
# @dummy
# @environment sgp.ci:kit_passives/scout_to_archer
#
# Changing from Scout to Archer replaces Speed III with Speed I and removes Scout jump and step bonuses.

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
