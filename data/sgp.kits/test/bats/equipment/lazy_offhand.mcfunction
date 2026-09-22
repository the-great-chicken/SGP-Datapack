#> sgp.kits:bats/equipment/lazy_offhand
# @dummy
# @environment sgp.ci:bats_equipment
#
# An item moved into offhand while Bats is active is hidden on the next tick and
# restored without changing its item data.

function sgp.ci:bats_equipment/fixture
function sgp.ci:bats_equipment/hide
item replace entity @s weapon.offhand with apple[custom_data={ci_keep:4}] 3
data modify storage sgp.ci:bats_equipment offhand_before set from entity @s Inventory[{Slot:-106b}]

scoreboard players set @s sgp.duration_ability 2
function sgp.kits:abilities/bats/tick
assert items entity @s weapon.offhand apple[custom_data~{ci_keep:4,hidden_vanilla:1b}]

scoreboard players set @s sgp.duration_ability 1
function sgp.kits:abilities/bats/tick
data modify storage sgp.ci:bats_equipment offhand_after set from entity @s Inventory[{Slot:-106b}]
execute store success score @s sgp.dummy run data modify storage sgp.ci:bats_equipment offhand_after set from storage sgp.ci:bats_equipment offhand_before
assert score @s sgp.dummy matches 0
