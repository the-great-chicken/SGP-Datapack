#> sgp.kits:abilities/illusions/remove_illusions

execute if entity @s[type=mannequin] at @s \
    run particle minecraft:reverse_portal ~ ~1 ~ 0.4 0.4 0.4 0 50

execute if entity @s[type=mannequin] \
    run scoreboard players add #nbr_illusions_left sgp.dummy 1

tp @s ~ ~-1000 ~
kill @s