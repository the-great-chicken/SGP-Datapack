
$execute as @s[tag=sgp.$(reward)] run tellraw @s {"text":"You arldy have get this reward","color":"red"}
$execute as @s[tag=sgp.$(reward)] run return fail
$$(function)
tag @s add sgp.reward
$tag @s add sgp.$(reward)
