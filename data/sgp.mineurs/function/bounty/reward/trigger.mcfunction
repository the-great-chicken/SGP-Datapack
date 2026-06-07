#> sgp.mineurs:bounty/reward/trigger

execute if score @s sgp.reward matches 1 run function sgp.mineurs:bounty/reward/macros {reward:"strength", function:"effect give @s strength 120 0 true"}
execute if score @s sgp.reward matches 2 run function sgp.mineurs:bounty/reward/macros {reward:"absorption", function:"effect give @s absorption infinite 9 true"}
execute if score @s sgp.reward matches 3 run function sgp.mineurs:bounty/reward/macros {reward:"max_health", function:"attribute @s minecraft:max_health modifier add sgp.bounty_reward 6 add_value"}
execute if score @s sgp.reward matches 4 run function sgp.mineurs:bounty/reward/macros {reward:"items", function:"loot give @s loot sgp.mineurs:reward_bounty_items"}

scoreboard players set @s sgp.reward 0

# Duplicate reward: allow choosing another one.
execute if entity @s[tag=sgp.reward_retry] run scoreboard players enable @s sgp.reward
execute if entity @s[tag=sgp.reward_retry] run tag @s remove sgp.reward_retry
execute if entity @s[tag=sgp.reward_handled] run return run tag @s remove sgp.reward_handled

# Invalid id: allow retry.
scoreboard players enable @s sgp.reward
tellraw @s {text:"Cette récompense n'existe pas.", color:red}