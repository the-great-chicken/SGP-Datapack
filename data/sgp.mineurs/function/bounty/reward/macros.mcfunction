tag @s add sgp.reward
$execute as @s[tag=sgp.$(reward)] run return run tellraw @s {"text":"You have already received this reward","color":"red"}
$$(function)
$tag @s add sgp.$(reward)
