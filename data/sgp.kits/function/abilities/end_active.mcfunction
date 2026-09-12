#> sgp.kits:abilities/end_active
# End the duration ability while the player's current kit tag still identifies it.

execute unless score @s sgp.duration_ability matches 1.. run return 0
scoreboard players set @s sgp.duration_ability 1
execute at @s run function sgp.kits:abilities/route_tick
scoreboard players set @s sgp.duration_ability 0
