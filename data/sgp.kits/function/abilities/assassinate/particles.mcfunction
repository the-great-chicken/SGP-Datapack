#> sgp.kits:abilities/assassinate/particles

execute positioned ^ ^ ^0.5 run particle minecraft:soul ~ ~1 ~ 0.8 0.8 0.8 0.01 5 normal @a

execute if score @s sgp.cooldown_ability matches 100 run function sgp.kits:abilities/assassinate/disable