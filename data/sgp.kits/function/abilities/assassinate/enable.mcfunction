#> sgp.kits:abilities/assassinate/enable

scoreboard players set @s sgp.cooldown_ability 400

tag @s add sgp.assassin

effect give @s minecraft:resistance infinite 4 true
attribute @s minecraft:knockback_resistance modifier add sgp:assassinate 1 add_value