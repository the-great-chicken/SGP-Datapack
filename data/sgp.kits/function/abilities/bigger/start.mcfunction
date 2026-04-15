#> sgp.kits:abilities/bigger/start

execute store result score @s sgp.cooldown_ability run data get storage sgp:data kits.ability_cooldowns.bigger.cooldown
execute store result score @s sgp.duration_ability run data get storage sgp:data kits.ability_cooldowns.bigger.duration

attribute @s minecraft:scale modifier add sgp:bigger 1 add_multiplied_base
attribute @s minecraft:jump_strength modifier add sgp:bigger 0.25 add_multiplied_base
attribute @s minecraft:entity_interaction_range modifier add sgp:bigger 0.5 add_multiplied_base
attribute @s minecraft:attack_damage modifier add sgp:bigger 1 add_multiplied_total