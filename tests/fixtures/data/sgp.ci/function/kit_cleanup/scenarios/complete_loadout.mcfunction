#> sgp.ci:kit_cleanup/scenarios/complete_loadout

function sgp.ci:kit_cleanup/loadout
function sgp.ci:kit_cleanup/expect_step {range:"9999..10001"}
function sgp.kits:clear
function sgp.ci:kit_cleanup/expect_empty
function sgp.ci:kit_cleanup/expect_step {range:"5999..6001"}
