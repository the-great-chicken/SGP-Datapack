#> sgp.ci:bats_equipment/equip
# Ordinary items, a custom model with and without model data, and varied armor.

clear @s
item replace entity @s hotbar.0 with diamond_sword[damage=7,enchantments={unbreaking:3},custom_name={text:"CI sword"},custom_data={ci_keep:1}]
item replace entity @s hotbar.1 with feather[item_model="minecraft:diamond",custom_model_data={floats:[1.5],flags:[true],strings:["keep"],colors:[16711680]},custom_data={ci_keep:2}]
item replace entity @s hotbar.2 with stick[item_model="minecraft:diamond"]
item replace entity @s weapon.offhand with bread 37
item replace entity @s armor.head with diamond_helmet[item_model="minecraft:carved_pumpkin",damage=9]
item replace entity @s armor.chest with leather_chestplate[dyed_color=65280,enchantments={protection:2}]
item replace entity @s armor.legs with iron_leggings[custom_data={ci_keep:3}]
item replace entity @s armor.feet with golden_boots[equippable={slot:feet,asset_id:"minecraft:iron"}]
