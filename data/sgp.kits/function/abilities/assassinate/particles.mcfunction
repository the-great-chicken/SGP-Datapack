#> sgp.kits:abilities/assassinate/particles

# ^ ^ ^0.5 is a mediocre but easy way to compensate for the particles lagging behind
execute positioned ^ ^ ^0.5 run particle minecraft:soul ~ ~1 ~ 0.8 0.8 0.8 0.01 5 normal @a

execute if score @s sgp.cooldown_ability matches 100 run function sgp.kits:abilities/assassinate/disable