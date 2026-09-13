#> sgp.kits:bats/equipment/empty_slots
# @dummy
# @environment sgp.ci:bats_equipment
#
# Processing empty slots must not create items, including after the same helpers processed a full loadout.

function sgp.ci:bats_equipment/fixture
function sgp.ci:bats_equipment/hide
function sgp.kits:abilities/bats/end
clear @s
function sgp.ci:bats_equipment/snapshot {key:empty}
function sgp.ci:bats_equipment/hide
function sgp.ci:bats_equipment/expect_snapshot {key:empty}
function sgp.kits:abilities/bats/end
function sgp.ci:bats_equipment/expect_snapshot {key:empty}
