#> sgp.kits:abilities/fangs/start

execute store result score @s sgp.cooldown_ability run data get storage sgp:data kits.ability_cooldowns.fangs.cooldown

scoreboard players set #nbr_fangs sgp.dummy 5
execute rotated as @s rotated ~ 0 positioned ^-0.4 ^ ^3.5 align y run function sgp.kits:abilities/fangs/summon

scoreboard players set #nbr_fangs sgp.dummy 5
execute rotated as @s rotated ~ 0 positioned ^0.4 ^ ^4.3 align y run function sgp.kits:abilities/fangs/summon