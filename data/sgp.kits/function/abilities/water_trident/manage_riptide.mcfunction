# If the player IS in water and DOES NOT have Riptide, add it
execute if block ~ ~ ~ minecraft:water \
    unless items entity @s weapon.mainhand *[enchantments~[{enchantments:"minecraft:riptide"}]] \
        run item modify entity @s weapon.mainhand sgp.kits:add_riptide

execute if block ~ ~1 ~ minecraft:water \
    unless items entity @s weapon.mainhand *[enchantments~[{enchantments:"minecraft:riptide"}]] \
        run item modify entity @s weapon.mainhand sgp.kits:add_riptide

execute if block ~ ~-1 ~ minecraft:water \
    unless items entity @s weapon.mainhand *[enchantments~[{enchantments:"minecraft:riptide"}]] \
        run item modify entity @s weapon.mainhand sgp.kits:add_riptide

# 2. If the player is on cooldown (score is 1 or higher), ensure they have Riptide to prevent throwing
execute if score @s sgp.cooldown_water_trident matches 1.. \
    unless items entity @s weapon.mainhand *[enchantments~[{enchantments:"minecraft:riptide"}]] \
        run item modify entity @s weapon.mainhand sgp.kits:add_riptide

# If the player is NOT in water and DOES have Riptide, remove it
execute unless block ~ ~ ~ minecraft:water unless block ~ ~1 ~ minecraft:water unless block ~ ~-1 ~ minecraft:water \
    unless score @s sgp.cooldown_water_trident matches 1.. \
        if items entity @s weapon.mainhand *[enchantments~[{enchantments:"minecraft:riptide"}]] \
            run item modify entity @s weapon.mainhand sgp.kits:remove_riptide