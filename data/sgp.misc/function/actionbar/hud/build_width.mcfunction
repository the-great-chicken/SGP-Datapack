#> sgp.misc:actionbar/hud/build_width
#
# Builds the normal actionbar width used by the zero-width HUD overlay.
#
# Dynamic actionbar wrappers declare their own widths in per-player scores.
# Fixed timer/cooldown wrappers copy centralized constants when refreshed.
# Separator width is included here as:
#   sum(segment widths) + separator_width * (active_segment_count - 1)

scoreboard players set @s sgp.ab.normal_width 0
scoreboard players set @s sgp.ab.normal_count 0

scoreboard players operation @s sgp.ab.normal_width += #test_width sgp.dummy
scoreboard players operation @s sgp.ab.normal_count += #test_width_count sgp.dummy

execute if score @s sgp.ab.reward_1 matches 1.. run scoreboard players operation @s sgp.ab.normal_width += @s sgp.ab.reward_1_width
execute if score @s sgp.ab.reward_1 matches 1.. run scoreboard players add @s sgp.ab.normal_count 1

execute if score @s sgp.ab.reward_2 matches 1.. run scoreboard players operation @s sgp.ab.normal_width += @s sgp.ab.reward_2_width
execute if score @s sgp.ab.reward_2 matches 1.. run scoreboard players add @s sgp.ab.normal_count 1

execute if score @s sgp.ab.reward_3 matches 1.. run scoreboard players operation @s sgp.ab.normal_width += @s sgp.ab.reward_3_width
execute if score @s sgp.ab.reward_3 matches 1.. run scoreboard players add @s sgp.ab.normal_count 1

execute if score @s sgp.ab.location matches 1.. run scoreboard players operation @s sgp.ab.normal_width += @s sgp.ab.location_width
execute if score @s sgp.ab.location matches 1.. run scoreboard players operation @s sgp.ab.normal_count += @s sgp.ab.location

execute if score @s sgp.ab.hide_hider matches 1.. run scoreboard players operation @s sgp.ab.normal_width += #sgp.ab.width.hide_hider sgp.dummy
execute if score @s sgp.ab.hide_hider matches 1.. if score #hider sgp.timer matches 10.. run scoreboard players operation @s sgp.ab.normal_width += 12 sgp.dummy
execute if score @s sgp.ab.hide_hider matches 1.. run scoreboard players add @s sgp.ab.normal_count 1

function #sgp.misc:actionbar/build_width_extensions

# Water trident still uses the normal Actionbar Mixer line for now.
execute if score @s sgp.ab.water_trident_cooldown matches 1 run scoreboard players operation @s sgp.ab.normal_width += #sgp.ab.width.water_trident sgp.dummy
execute if score @s sgp.ab.water_trident_cooldown matches 1 run scoreboard players add @s sgp.ab.normal_count 1

execute if score @s sgp.ab.normal_count matches 1.. run scoreboard players remove @s sgp.ab.normal_count 1
scoreboard players operation @s sgp.ab.normal_count *= #sgp.ab.width.separator sgp.dummy
scoreboard players operation @s sgp.ab.normal_width += @s sgp.ab.normal_count
