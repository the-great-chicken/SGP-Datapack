#> sgp.ci:kit_cleanup/expect_empty
# Require no selected kit, inventory/equipment, or active effects after kit cleanup.

assert score @s sgp.kit_id matches -1
assert not data entity @s Inventory[0]
assert not data entity @s equipment.head.id
assert not data entity @s equipment.chest.id
assert not data entity @s equipment.legs.id
assert not data entity @s equipment.feet.id
assert not data entity @s equipment.offhand.id
assert not data entity @s active_effects[0]
