#> sgp.kits:abilities/assassinate/start

execute store result score @s sgp.cooldown_ability run data get storage sgp:data kits.ability_cooldowns.assassinate.cooldown
execute store result score @s sgp.duration_ability run data get storage sgp:data kits.ability_cooldowns.assassinate.duration

tag @s add sgp.assassin

effect give @s minecraft:resistance infinite 4 true
attribute @s minecraft:knockback_resistance modifier add sgp:assassinate 1 add_value