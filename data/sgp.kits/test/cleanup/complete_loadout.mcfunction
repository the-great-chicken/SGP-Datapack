#> sgp.kits:cleanup/complete_loadout
# @dummy
# @environment sgp.ci:kit_cleanup/complete_loadout
#
# Clearing a kit empties the hotbar, inventory, offhand, and armor, removes effects, and resets kit selection.

function sgp.ci:kit_cleanup/loadout
function sgp.ci:kit_cleanup/expect_step {range:"9999..10001"}
function sgp.kits:clear
function sgp.ci:kit_cleanup/expect_empty
function sgp.ci:kit_cleanup/expect_step {range:"5999..6001"}
