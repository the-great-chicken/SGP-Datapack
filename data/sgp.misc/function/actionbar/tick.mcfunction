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

scoreboard players remove @a[scores={sgp.ab.location=1..}] sgp.ab.location 1
execute as @a[scores={sgp.ab.location=0}] run function dah.actbar_mixer:remove/this {id:"sgp:location"}
execute as @a[scores={sgp.ab.location=0}] run scoreboard players reset @s sgp.ab.location

scoreboard players remove @a[scores={sgp.ab.hide_hider=1..}] sgp.ab.hide_hider 1
execute as @a[scores={sgp.ab.hide_hider=0}] run function dah.actbar_mixer:remove/this {id:"sgp:hide_hider"}
execute as @a[scores={sgp.ab.hide_hider=0}] run scoreboard players reset @s sgp.ab.hide_hider

scoreboard players remove @a[scores={sgp.ab.pco_cabane=1..}] sgp.ab.pco_cabane 1
execute as @a[scores={sgp.ab.pco_cabane=0}] run function dah.actbar_mixer:remove/this {id:"sgp:pco_cabane"}
execute as @a[scores={sgp.ab.pco_cabane=0}] run scoreboard players reset @s sgp.ab.pco_cabane
