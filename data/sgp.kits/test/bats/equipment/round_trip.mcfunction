#> sgp.kits:bats/equipment/round_trip
# @dummy
# @environment sgp.ci:bats_equipment
#
# Hiding changes item appearance until expiry, then restores all original item properties. Repeating cleanup must be harmless.

function sgp.ci:bats_equipment/fixture
function sgp.ci:bats_equipment/snapshot {key:before}
function sgp.ci:bats_equipment/hide
execute store success score @s sgp.dummy if items entity @s armor.head *[item_model="sgp.kits:empty_model"]
assert score @s sgp.dummy matches 1
execute store success score @s sgp.dummy if items entity @s hotbar.0 *[item_model="sgp.kits:empty_model"]
assert score @s sgp.dummy matches 1
function sgp.ci:bats_equipment/snapshot {key:hidden}

scoreboard players set @s sgp.duration_ability 2
function sgp.kits:abilities/bats/tick
function sgp.ci:bats_equipment/expect_snapshot {key:hidden}
scoreboard players set @s sgp.duration_ability 1
function sgp.kits:abilities/bats/tick
function sgp.ci:bats_equipment/expect_snapshot {key:before}
function sgp.kits:abilities/bats/end
function sgp.ci:bats_equipment/expect_snapshot {key:before}
