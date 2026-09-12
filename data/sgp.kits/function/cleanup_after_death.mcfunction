#> sgp.kits:cleanup_after_death
# End the active ability before removing its kit identity, then clear the loadout and reward progress.

# Reset ability
function sgp.kits:abilities/end_active
scoreboard players set @s sgp.cooldown_ability 0

function sgp.kits:kit_tags/reset
scoreboard players set @s sgp.kills_give_1 0
scoreboard players set @s sgp.kills_give_2 0
scoreboard players set @s sgp.kills_give_3 0
scoreboard players set @s sgp.just_died 0

function sgp.kits:clear
