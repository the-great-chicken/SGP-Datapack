#> sgp.kits:abilities/water_trident/add_riptide

execute if items entity @s weapon.mainhand *[enchantments~[{enchantments:"minecraft:riptide"}]] run return 1
item modify entity @s weapon.mainhand sgp.kits:add_riptide