execute as @s[tag=!sgp.climbing] at @s if predicate sgp.world:is_climbing run tag @s add sgp.starts_climbing

execute as @s[tag=sgp.starts_climbing] run attribute @s minecraft:generic.gravity modifier add climbing_boost -1 add_multiplied_total
execute as @s[tag=sgp.starts_climbing] run tag @s add sgp.climbing
execute as @s[tag=sgp.starts_climbing] run tag @s remove sgp.starts_climbing

execute as @s[tag=sgp.climbing] at @s unless predicate sgp.world:is_climbing run attribute @s minecraft:generic.gravity modifier remove climbing_boost
execute as @s[tag=sgp.climbing] at @s unless predicate sgp.world:is_climbing run tag @s remove sgp.climbing