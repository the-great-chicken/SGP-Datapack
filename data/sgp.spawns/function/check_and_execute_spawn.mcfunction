#> sgp.spawns:check_and_execute_spawn
# 
# Check if a player wants to tp to a spawn, and execute the corresponding one if so

$execute at @s rotated as @s as @a[scores={sgp.spawn_$(number)=1..}] run function sgp.spawns:spawn {number:$(number)}