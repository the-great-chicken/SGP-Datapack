#> sgp.mineurs:bounty/reward/macros
# `{reward, function}`
#
# Test if the player has already received the reward if not give it to him

# This reward id exists, so the trigger has been handled.
tag @s add sgp.reward_handled

$execute if entity @s[tag=sgp.$(reward)] run tag @s add sgp.reward_retry
$execute if entity @s[tag=sgp.$(reward)] run return run tellraw @s {text:"Tu as déjà récupéré cette récompense durant cette vie !", color:red}

$$(function)

$tag @s add sgp.$(reward)