#> sgp.misc:actionbar/ability_cooldown
#
# Shows or refreshes the main ability cooldown actionbar segment.
# The value is displayed as a gold/white fill-up progress bar.

# Infer the max cooldown centrally when this segment first appears.
# Also re-infer it if the cooldown value increased since the last rendered tick,
# which covers a new cooldown starting in the same tick as the previous one expired.
execute unless score @s sgp.ab.ability_cooldown matches 1 run scoreboard players operation @s sgp.ab.ability_cooldown_max = @s sgp.cooldown_ability
execute unless score @s sgp.ab.ability_cooldown matches 1 run scoreboard players set @s sgp.ab.ability_cooldown_last_fill -1
execute if score @s sgp.cooldown_ability > @s sgp.ab.ability_cooldown_last_current run scoreboard players operation @s sgp.ab.ability_cooldown_max = @s sgp.cooldown_ability
execute if score @s sgp.cooldown_ability > @s sgp.ab.ability_cooldown_last_current run scoreboard players set @s sgp.ab.ability_cooldown_last_fill -1
execute if score @s sgp.cooldown_ability > @s sgp.ab.ability_cooldown_max run scoreboard players operation @s sgp.ab.ability_cooldown_max = @s sgp.cooldown_ability

scoreboard players operation #sgp.ab.current sgp.dummy = @s sgp.cooldown_ability
scoreboard players operation #sgp.ab.max sgp.dummy = @s sgp.ab.ability_cooldown_max
function sgp.misc:actionbar/progress_bar/calculate
scoreboard players operation @s sgp.ab.ability_cooldown_last_current = @s sgp.cooldown_ability

execute if score @s sgp.ab.ability_cooldown matches 1 if score #sgp.ab.filled sgp.dummy = @s sgp.ab.ability_cooldown_last_fill run return 0
scoreboard players operation @s sgp.ab.ability_cooldown_last_fill = #sgp.ab.filled sgp.dummy

data modify storage dah:actbar new set value {id:"sgp:ability_cooldown",order:150,text:[]}
function sgp.misc:actionbar/progress_bar/append
function dah.actbar_mixer:new/update_id
scoreboard players set @s sgp.ab.ability_cooldown 1
