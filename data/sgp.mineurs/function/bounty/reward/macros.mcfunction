# sgp.mineurs:bounty/reward/macros
#
# test if the player has already received the reward if not give it to him

tag @s add sgp.no_reward
$execute as @s[tag=sgp.$(reward)] run return run tellraw @s {"text":"Tu as déjà récupéré cette récompense !","color":"red"}
tag @s remove sgp.no_reward
tag @s add sgp.reward
$$(function)
$tag @s add sgp.$(reward)
