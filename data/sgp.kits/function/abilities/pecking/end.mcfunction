#> sgp.kits:abilities/pecking/end

execute store result score @s sgp.cooldown_ability run data get storage sgp:data kits.ability_cooldowns.pecking.cooldown
tag @s remove sgp.is_pecking
scoreboard players set @s sgp.duration_ability 1