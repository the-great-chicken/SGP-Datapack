tag @s add sgp.no_reward
$execute as @s[tag=sgp.$(reward)] run return run tellraw @s {"text":"You have already received this reward","color":"red"}
tag @s remove sgp.no_reward
tag @s add sgp.reward
$$(function)
$tag @s add sgp.$(reward)
