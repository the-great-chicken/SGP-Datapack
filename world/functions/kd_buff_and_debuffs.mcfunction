scoreboard players operation @s kd = @s kills
scoreboard players operation @s kd *= 100 dummy
scoreboard players operation @s kd /= @s morts

execute if score @s kd >= 300 dummy if score @s kills >= 10 dummy run effect give @s minecraft:weakness 7 0 true
execute unless predicate majeurs:event_in_progress if score @s kd <= 50 dummy if score @s morts >= 10 dummy run effect give @s minecraft:strength 7 0 true
execute if score @s kd <= 50 dummy if score @s morts >= 10 dummy run effect give @s minecraft:regeneration 7 0 true