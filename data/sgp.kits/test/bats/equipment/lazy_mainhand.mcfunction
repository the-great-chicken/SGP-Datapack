#> sgp.kits:bats/equipment/lazy_mainhand
# @dummy
# @environment sgp.ci:bats_equipment
#
# Only the selected hotbar stack is hidden eagerly; selecting another stack hides
# it on the active tick and both stacks restore exactly at the end.

function sgp.ci:bats_equipment/fixture
function sgp.ci:bats_equipment/snapshot {key:before}
function sgp.ci:bats_equipment/hide
assert items entity @s hotbar.0 *[custom_data~{hidden_vanilla:1b}]
assert not items entity @s hotbar.1 *[custom_data~{hidden_special:1b}|custom_data~{hidden_vanilla:1b}]
assert not items entity @s hotbar.2 *[custom_data~{hidden_special:1b}|custom_data~{hidden_vanilla:1b}]

dummy @s selectslot 2
scoreboard players set @s sgp.duration_ability 2
function sgp.kits:abilities/bats/tick
assert not entity @e[type=armor_stand,distance=..0.1]
assert items entity @s hotbar.1 *[custom_data~{hidden_special:1b}]
assert not items entity @s hotbar.2 *[custom_data~{hidden_special:1b}|custom_data~{hidden_vanilla:1b}]

scoreboard players set @s sgp.duration_ability 1
function sgp.kits:abilities/bats/tick
function sgp.ci:bats_equipment/expect_snapshot {key:before}
