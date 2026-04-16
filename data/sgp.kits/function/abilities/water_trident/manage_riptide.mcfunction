#> sgp.kits:abilities/water_trident/manage_riptide

# If the player is NOT in water AND there is no temp_water marker nearby, remove Riptide and end.
execute positioned ~ ~ ~ unless predicate sgp.misc:is_in_water \
    positioned ~ ~0.8 ~ unless predicate sgp.misc:is_in_water \
    positioned ~ ~-0.8 ~ unless predicate sgp.misc:is_in_water \
    unless entity @e[tag=sgp.marker,name="temp_water",distance=..2] \
    run return run execute if items entity @s weapon.mainhand *[enchantments~[{enchantments:"minecraft:riptide"}]] \
        run item modify entity @s weapon.mainhand sgp.kits:remove_riptide

# If the function hasn't returned, they are in water (or just placed it). Give Riptide!
execute unless items entity @s weapon.mainhand *[enchantments~[{enchantments:"minecraft:riptide"}]] \
    run item modify entity @s weapon.mainhand sgp.kits:add_riptide