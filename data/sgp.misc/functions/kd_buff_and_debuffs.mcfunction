scoreboard players operation @s sgp.kd = @s sgp.kills
scoreboard players operation @s sgp.kd *= 100 sgp.dummy
scoreboard players operation @s sgp.kd /= @s morts

execute unless predicate sgp.majeurs:event_in_progress if score @s sgp.kd <= 50 sgp.dummy if score @s morts >= 10 sgp.dummy run effect give @s minecraft:strength 7 0 true
execute if score @s sgp.kd >= 300 sgp.dummy if score @s sgp.kills >= 10 sgp.dummy run effect give @s minecraft:weakness 7 0 true
execute if score @s sgp.kd <= 50 sgp.dummy if score @s morts >= 10 sgp.dummy run effect give @s minecraft:regeneration 7 0 true