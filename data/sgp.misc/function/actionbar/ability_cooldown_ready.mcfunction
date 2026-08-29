#> sgp.misc:actionbar/ability_cooldown_ready
#
# Keeps the ability HUD visible as a full bar while the player's main ability is ready.
# This is intentionally separate from the live cooldown path so a new cooldown can
# still re-infer its max value cleanly when it starts.

execute if score @s sgp.ab.hud_ability matches 1 \
    if score @s sgp.ab.hud_ability_fill matches 20 \
    unless score @s sgp.ab.ability_cooldown matches 1 \
        run return 0

scoreboard players set @s sgp.ab.hud_ability_fill 20
scoreboard players set @s sgp.ab.hud_ability 1
scoreboard players set @s sgp.ab.ability_cooldown 0
scoreboard players set @s sgp.ab.ability_cooldown_last_fill 20
scoreboard players reset @s sgp.ab.ability_cooldown_max
scoreboard players reset @s sgp.ab.ability_cooldown_last_current
