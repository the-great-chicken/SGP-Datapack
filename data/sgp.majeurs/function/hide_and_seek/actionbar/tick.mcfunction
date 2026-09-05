#> sgp.majeurs:hide_and_seek/actionbar/tick
#
# Expire the Cache-cache hiding timer actionbar segment.

scoreboard players remove @a[scores={sgp.ab.hide_hider=1..}] sgp.ab.hide_hider 1
execute as @a[scores={sgp.ab.hide_hider=0}] run function dah.actbar_mixer:remove/this {id:"sgp:hide_hider"}
execute as @a[scores={sgp.ab.hide_hider=0}] run scoreboard players reset @s sgp.ab.hide_hider
