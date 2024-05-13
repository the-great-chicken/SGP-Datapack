scoreboard players operation @s kd = @s le5
scoreboard players operation @s kd *= 100 test
scoreboard players operation @s kd /= @s morts

execute if score @s kd >= 300 test if score @s le5 >= 10 test run effect give @s minecraft:weakness 7 0 true
execute unless predicate majeurs:event_in_progress if score @s kd <= 50 test if score @s morts >= 10 test run effect give @s minecraft:strength 7 0 true
execute if score @s kd <= 50 test if score @s morts >= 10 test run effect give @s minecraft:regeneration 7 0 true