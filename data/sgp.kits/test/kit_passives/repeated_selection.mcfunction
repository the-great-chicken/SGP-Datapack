#> sgp.kits:kit_passives/repeated_selection
# @dummy
# @environment sgp.ci:kit_passives/repeated_selection
#
# Repeated Scout selection does not stack its bonuses, and leaving restores normal movement.

function sgp.ci:kit_passives/fixture
function sgp.ci:kit_passives/select {kit:eclaireur}
function sgp.ci:kit_passives/select {kit:eclaireur}
function sgp.ci:kit_passives/expect_speed {range:"1599..1601"}
function sgp.ci:kit_passives/expect_step {range:"11999..12001"}
function sgp.ci:kit_passives/select {kit:combattant}
function sgp.ci:kit_passives/expect_speed {range:"999..1001"}
function sgp.ci:kit_passives/expect_step {range:"5999..6001"}
