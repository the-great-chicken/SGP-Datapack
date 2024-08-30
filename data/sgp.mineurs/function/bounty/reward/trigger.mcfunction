#> sgp.mineurs:bounty/reward/trigger
#
#trigger the reward
execute if score @s sgp.reward matches 1 run function sgp.mineurs:bounty/reward/macros {reward:"strength",function:"effect give @s strength 120 0 true"}
execute if score @s sgp.reward matches 2 run function sgp.mineurs:bounty/reward/macros {reward:"absorbtion",function:"effect give @s absorption infinite 9 true"}
execute if score @s sgp.reward matches 3 run function sgp.mineurs:bounty/reward/macros {reward:"max_health",function:"attribute @s minecraft:generic.max_health modifier add sgp.bounty_reward 6 add_value"}
execute if score @s sgp.reward matches 4 run function sgp.mineurs:bounty/reward/macros {reward:"items",function:"loot give @s loot sgp.mineurs:reward_bounty_items"}

scoreboard players set @s sgp.reward 0
execute as @s[tag=sgp.no_reward] run scoreboard players enable @s sgp.reward
#check if the reward exists
execute as @s[tag=sgp.reward] run return run tag @s remove sgp.reward
scoreboard players enable @s sgp.reward
tellraw @s ["",{"text":"Cette récompense n'existe pas.","color":"red"}]