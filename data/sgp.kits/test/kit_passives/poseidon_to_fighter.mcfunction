#> sgp.kits:kit_passives/poseidon_to_fighter
# @dummy
# @environment sgp.ci:kit_passives/poseidon_to_fighter
#
# Leaving Poseidon removes its speed penalty and water-related effects.

function sgp.ci:kit_passives/fixture
function sgp.ci:kit_passives/select {kit:poseidon}
function sgp.ci:kit_passives/expect_speed {range:"399..401"}
assert entity @s[nbt={active_effects:[{id:"minecraft:resistance",amplifier:2b},{id:"minecraft:hunger",amplifier:3b},{id:"minecraft:conduit_power"}]}]
function sgp.ci:kit_passives/select {kit:combattant}
function sgp.ci:kit_passives/expect_speed {range:"999..1001"}
assert score @s sgp.kit_id matches 1
assert not data entity @s active_effects[0]
