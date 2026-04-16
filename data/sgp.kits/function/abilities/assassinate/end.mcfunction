#> sgp.kits:abilities/assassinate/end

effect clear @s resistance
attribute @s knockback_resistance modifier remove sgp:assassinate
scoreboard players set @s sgp.duration_ability 1
tag @s remove sgp.assassin