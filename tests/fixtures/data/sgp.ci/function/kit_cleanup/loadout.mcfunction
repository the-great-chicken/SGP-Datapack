#> sgp.ci:kit_cleanup/loadout

scoreboard players set @s sgp.kit_id 5
attribute @s minecraft:step_height base set 0.6
attribute @s minecraft:step_height modifier add sgp:kit 0.4 add_value
item replace entity @s hotbar.0 with diamond_sword
item replace entity @s hotbar.8 with bow
item replace entity @s inventory.0 with arrow 64
item replace entity @s inventory.26 with golden_apple 3
item replace entity @s weapon.offhand with shield
item replace entity @s armor.head with diamond_helmet
item replace entity @s armor.chest with diamond_chestplate
item replace entity @s armor.legs with diamond_leggings
item replace entity @s armor.feet with diamond_boots
effect give @s speed 60 1 true
effect give @s jump_boost 60 1 true
effect give @s fire_resistance 60 0 true
assert data entity @s Inventory[0]
assert data entity @s active_effects[0]
