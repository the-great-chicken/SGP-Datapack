#> sgp.misc:actionbar/ability_cooldown
#
# Shows or refreshes the main ability cooldown HUD overlay.
# Cooldown progress is converted to a 0..20 frame index, then rendered as the
# corresponding resource-pack glyph by the Actionbar Mixer display override.

# Infer the max cooldown centrally when this HUD first appears.
# Also re-infer it if the cooldown value increased since the last rendered tick,
# which covers a new cooldown starting in the same tick as the previous one expired.
execute unless score @s sgp.ab.ability_cooldown matches 1 run scoreboard players operation @s sgp.ab.ability_cooldown_max = @s sgp.cooldown_ability
execute unless score @s sgp.ab.ability_cooldown matches 1 run scoreboard players set @s sgp.ab.ability_cooldown_last_fill -1

execute if score @s sgp.cooldown_ability > @s sgp.ab.ability_cooldown_last_current run scoreboard players operation @s sgp.ab.ability_cooldown_max = @s sgp.cooldown_ability
execute if score @s sgp.cooldown_ability > @s sgp.ab.ability_cooldown_last_current run scoreboard players set @s sgp.ab.ability_cooldown_last_fill -1

execute if score @s sgp.cooldown_ability > @s sgp.ab.ability_cooldown_max run scoreboard players operation @s sgp.ab.ability_cooldown_max = @s sgp.cooldown_ability

scoreboard players operation #sgp.ab.current sgp.dummy = @s sgp.cooldown_ability
scoreboard players operation #sgp.ab.max sgp.dummy = @s sgp.ab.ability_cooldown_max
function sgp.misc:actionbar/cooldown_frame/calculate
scoreboard players operation @s sgp.ab.ability_cooldown_last_current = @s sgp.cooldown_ability

# The HUD display override reads these scores each Actionbar Mixer render.
execute if score @s sgp.ab.hud_ability matches 1 \
    if score @s sgp.ab.ability_cooldown matches 1 \
        if score #sgp.ab.filled sgp.dummy = @s sgp.ab.ability_cooldown_last_fill \
            run return 0
            
scoreboard players operation @s sgp.ab.ability_cooldown_last_fill = #sgp.ab.filled sgp.dummy
scoreboard players operation @s sgp.ab.hud_ability_fill = #sgp.ab.filled sgp.dummy
scoreboard players set @s sgp.ab.hud_ability 1
scoreboard players set @s sgp.ab.ability_cooldown 1
