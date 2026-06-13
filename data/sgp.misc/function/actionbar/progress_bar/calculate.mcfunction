#> sgp.misc:actionbar/progress_bar/calculate
#
# Computes a 0..20 filled-bar index from cooldown ticks.
# Inputs in sgp.dummy:
# - #sgp.ab.current: current cooldown ticks remaining
# - #sgp.ab.max: inferred max cooldown ticks
# Output in sgp.dummy:
# - #sgp.ab.filled: number of gold bars to display
#
# Fill-up style: gold = elapsed cooldown, white = remaining cooldown.

scoreboard players set #sgp.ab.bar_length sgp.dummy 20

execute unless score #sgp.ab.current sgp.dummy matches 0.. run scoreboard players set #sgp.ab.current sgp.dummy 0
execute unless score #sgp.ab.max sgp.dummy matches 1.. run scoreboard players operation #sgp.ab.max sgp.dummy = #sgp.ab.current sgp.dummy
execute unless score #sgp.ab.max sgp.dummy matches 1.. run scoreboard players set #sgp.ab.max sgp.dummy 1
execute if score #sgp.ab.current sgp.dummy > #sgp.ab.max sgp.dummy run scoreboard players operation #sgp.ab.max sgp.dummy = #sgp.ab.current sgp.dummy

scoreboard players operation #sgp.ab.filled sgp.dummy = #sgp.ab.max sgp.dummy
scoreboard players operation #sgp.ab.filled sgp.dummy -= #sgp.ab.current sgp.dummy
execute if score #sgp.ab.filled sgp.dummy matches ..0 run scoreboard players set #sgp.ab.filled sgp.dummy 0

# floor((max - current) * bar_length / max).
# This keeps the first rendered frame at 0 filled bars when the cooldown starts,
# and it avoids rendering a full bar while the cooldown is still active.
scoreboard players operation #sgp.ab.filled sgp.dummy *= #sgp.ab.bar_length sgp.dummy
scoreboard players operation #sgp.ab.filled sgp.dummy /= #sgp.ab.max sgp.dummy

execute if score #sgp.ab.filled sgp.dummy matches ..0 run scoreboard players set #sgp.ab.filled sgp.dummy 0
execute if score #sgp.ab.filled sgp.dummy > #sgp.ab.bar_length sgp.dummy run scoreboard players operation #sgp.ab.filled sgp.dummy = #sgp.ab.bar_length sgp.dummy
