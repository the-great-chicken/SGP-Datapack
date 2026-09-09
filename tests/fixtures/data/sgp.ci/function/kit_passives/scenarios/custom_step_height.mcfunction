#> sgp.ci:kit_passives/scenarios/custom_step_height

function sgp.ci:kit_passives/fixture
attribute @s minecraft:step_height base set 0.8
attribute @s minecraft:step_height modifier add sgp.ci:passive_step 0.1 add_value
function sgp.ci:kit_passives/select {kit:eclaireur}
function sgp.ci:kit_passives/expect_step {range:"17999..18001"}
function sgp.ci:kit_passives/select {kit:tank}
function sgp.ci:kit_passives/expect_step {range:"8999..9001"}
