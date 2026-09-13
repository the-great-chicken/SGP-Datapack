#> sgp.kits:cleanup/repeated_cleanup
# @dummy
# @environment sgp.ci:kit_cleanup/repeated_cleanup
#
# Cleanup can be repeated, and a later loadout can still be equipped and cleared normally.

function sgp.ci:kit_cleanup/loadout
function sgp.kits:clear
function sgp.ci:kit_cleanup/expect_empty
function sgp.kits:clear
function sgp.ci:kit_cleanup/expect_empty
function sgp.ci:kit_cleanup/loadout
function sgp.ci:kit_cleanup/expect_step {range:"9999..10001"}
function sgp.kits:clear
function sgp.ci:kit_cleanup/expect_empty
function sgp.ci:kit_cleanup/expect_step {range:"5999..6001"}
