#> sgp.kits:abilities/fangs/trigger

scoreboard players set @s sgp.cooldown_ability 100

scoreboard players set #nbr_fangs sgp.dummy 8

execute rotated as @s rotated ~ 0 positioned ^ ^ ^3.5 align y run function sgp.kits:abilities/fangs/summon