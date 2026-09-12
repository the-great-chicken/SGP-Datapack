#> sgp.kits:cleanup_after_death
# End the active ability before removing its kit identity, then clear the loadout and reward progress.

scoreboard players set @s sgp.kit_id -1

# Reset ability
scoreboard players set @s sgp.duration_ability 1
execute at @s run function sgp.kits:abilities/route_tick
scoreboard players set @s sgp.cooldown_ability 0

function sgp.kits:kit_tags/reset
scoreboard players set @s sgp.kills_give_1 0
scoreboard players set @s sgp.kills_give_2 0
scoreboard players set @s sgp.kills_give_3 0
scoreboard players set @s sgp.just_died 0

function sgp.kits:clear
