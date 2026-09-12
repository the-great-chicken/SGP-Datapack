#> sgp.diorama:left_click/remove_piercing_weapon
#
# Remove diorama-added piercing outside the model when another player is in melee range.

execute unless entity @s[tag=sgp.around_model] \
    at @s if entity @a[distance=0.1..4] \
        if items entity @s weapon.mainhand *[piercing_weapon,enchantments~[{enchantments:"sgp.diorama:left_click_detection"}]] \
            run item modify entity @s weapon.mainhand sgp.diorama:remove_left_click_detect