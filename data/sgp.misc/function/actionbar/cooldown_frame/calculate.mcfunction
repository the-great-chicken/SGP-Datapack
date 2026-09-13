#> sgp.misc:actionbar/cooldown_frame/calculate
#
# Computes the 0..20 resource-pack HUD frame for an active ability cooldown.
# Inputs in sgp.dummy:
# - #sgp.ab.current: current cooldown ticks remaining
# - #sgp.ab.max: inferred max cooldown ticks
# Output in sgp.dummy:
# - #sgp.ab.filled: frame index, where 0 is just started and 20 is ready
#
# The frame represents elapsed cooldown progress: floor((max - current) * 20 / max).

execute unless score #sgp.ab.current sgp.dummy matches 0.. run scoreboard players set #sgp.ab.current sgp.dummy 0
execute unless score #sgp.ab.max sgp.dummy matches 1.. run scoreboard players operation #sgp.ab.max sgp.dummy = #sgp.ab.current sgp.dummy
execute unless score #sgp.ab.max sgp.dummy matches 1.. run scoreboard players set #sgp.ab.max sgp.dummy 1
execute if score #sgp.ab.current sgp.dummy > #sgp.ab.max sgp.dummy run scoreboard players operation #sgp.ab.max sgp.dummy = #sgp.ab.current sgp.dummy

scoreboard players operation #sgp.ab.filled sgp.dummy = #sgp.ab.max sgp.dummy
scoreboard players operation #sgp.ab.filled sgp.dummy -= #sgp.ab.current sgp.dummy
execute if score #sgp.ab.filled sgp.dummy matches ..0 run scoreboard players set #sgp.ab.filled sgp.dummy 0

# Scale elapsed progress to the resource pack's frame range 0..20.
# Flooring keeps the first active frame at 0 and avoids showing frame 20 early.
scoreboard players operation #sgp.ab.filled sgp.dummy *= #sgp.ab.bar_length sgp.dummy
scoreboard players operation #sgp.ab.filled sgp.dummy /= #sgp.ab.max sgp.dummy

execute if score #sgp.ab.filled sgp.dummy matches ..0 run scoreboard players set #sgp.ab.filled sgp.dummy 0
execute if score #sgp.ab.filled sgp.dummy > #sgp.ab.bar_length sgp.dummy run scoreboard players operation #sgp.ab.filled sgp.dummy = #sgp.ab.bar_length sgp.dummy
