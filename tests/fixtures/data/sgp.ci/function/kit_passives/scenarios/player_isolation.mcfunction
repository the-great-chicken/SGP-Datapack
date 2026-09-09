#> sgp.ci:kit_passives/scenarios/player_isolation

function sgp.ci:kit_passives/fixture
dummy PassivePeer spawn
execute as PassivePeer run function sgp.ci:kit_passives/fixture
execute as PassivePeer run function sgp.ci:kit_passives/select {kit:enderman}
function sgp.ci:kit_passives/select {kit:eclaireur}
function sgp.ci:kit_passives/select {kit:tank}
assert not data entity @s active_effects[0]
assert entity @a[name=PassivePeer,nbt={active_effects:[{id:"minecraft:regeneration"}]}]
assert score PassivePeer sgp.kit_id matches 9
execute as PassivePeer run function sgp.ci:kit_passives/expect_step {range:"5999..6001"}
