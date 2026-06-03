#> sgp.misc:remove_piercing_weapon
#
# Removes the piercing weapon component of the player's main weapon if he is
# currently aiming at an enemy in melee-range to avoid it changing the weapon behavior

execute unless entity @s[tag=sgp.around_model] \
    at @s if entity @a[distance=0.1..4] \
        if items entity @s weapon.mainhand *[piercing_weapon] \
            run item modify entity @s weapon.mainhand sgp.misc:remove_left_click_detect