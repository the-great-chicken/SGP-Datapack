#> sgp.misc:actionbar/tick
#
# Expires SGP-owned Actionbar Mixer segments.
# Each segment has its own scoreboard timer so simultaneous actionbars can
# disappear independently while Actionbar Mixer concatenates the visible parts.

scoreboard players remove @a[scores={sgp.ab.reward_1=1..}] sgp.ab.reward_1 1
execute as @a[scores={sgp.ab.reward_1=0}] run function dah.actbar_mixer:remove/this {id:"sgp:reward_1"}
execute as @a[scores={sgp.ab.reward_1=0}] run scoreboard players reset @s sgp.ab.reward_1

scoreboard players remove @a[scores={sgp.ab.reward_2=1..}] sgp.ab.reward_2 1
execute as @a[scores={sgp.ab.reward_2=0}] run function dah.actbar_mixer:remove/this {id:"sgp:reward_2"}
execute as @a[scores={sgp.ab.reward_2=0}] run scoreboard players reset @s sgp.ab.reward_2

scoreboard players remove @a[scores={sgp.ab.reward_3=1..}] sgp.ab.reward_3 1
execute as @a[scores={sgp.ab.reward_3=0}] run function dah.actbar_mixer:remove/this {id:"sgp:reward_3"}
execute as @a[scores={sgp.ab.reward_3=0}] run scoreboard players reset @s sgp.ab.reward_3

function #sgp.misc:actionbar/tick_extensions
