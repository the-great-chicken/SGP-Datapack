# If the player is NOT in water and DOES NOT have a cooldown.
# We attempt to remove Riptide (if they have it), and instantly END the function using `return`.
execute positioned ~ ~ ~ unless predicate sgp.misc:is_in_water \
    positioned ~ ~0.8 ~ unless predicate sgp.misc:is_in_water \
    positioned ~ ~-0.8 ~ unless predicate sgp.misc:is_in_water \
    unless score @s sgp.cooldown_water_trident matches 1.. \
    run return run execute if items entity @s weapon.mainhand *[enchantments~[{enchantments:"minecraft:riptide"}]] \
        run item modify entity @s weapon.mainhand sgp.kits:remove_riptide

# If the function hasn't returned yet, it guarantees the player IS in water OR on cooldown!
execute unless items entity @s weapon.mainhand *[enchantments~[{enchantments:"minecraft:riptide"}]] \
    run item modify entity @s weapon.mainhand sgp.kits:add_riptide