#> sgp.kits:enchantments/summon_custom_splash_potion
#
# Build one potion from the arrow's custom effects plus the supported vanilla mapping.

data modify storage sgp:macro splash_arrow set value {custom_effects:[]}
execute if data entity @s item.components."minecraft:potion_contents".custom_effects \
    run data modify storage sgp:macro splash_arrow.custom_effects set from entity @s item.components."minecraft:potion_contents".custom_effects
execute if data entity @s item.components."minecraft:potion_contents".potion \
    run function sgp.kits:enchantments/append_vanilla_splash_effect

execute if data storage sgp:macro splash_arrow.custom_effects[0] \
    run function sgp.kits:enchantments/summon_custom_effect_splash_potion with storage sgp:macro splash_arrow

data remove storage sgp:macro splash_arrow
kill @s
