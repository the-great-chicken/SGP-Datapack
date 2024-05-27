#> sgp.cosmetics:particles/ench_cycle
# 
# Cycles the Sharpness particle cloak around a player, spawning them at the
# right coordinates each time

execute if score #ench_particle sgp.dummy matches 1 run execute as @a[tag=ench_particle] at @s positioned ~0.21 ~1 ~-0.77 run function sgp.cosmetics:particles/ench_spawn
execute if score #ench_particle sgp.dummy matches 2 run execute as @a[tag=ench_particle] at @s positioned ~0.4 ~1 ~-0.69 run function sgp.cosmetics:particles/ench_spawn
execute if score #ench_particle sgp.dummy matches 3 run execute as @a[tag=ench_particle] at @s positioned ~0.57 ~1 ~-0.57 run function sgp.cosmetics:particles/ench_spawn
execute if score #ench_particle sgp.dummy matches 4 run execute as @a[tag=ench_particle] at @s positioned ~0.69 ~1 ~-0.4 run function sgp.cosmetics:particles/ench_spawn
execute if score #ench_particle sgp.dummy matches 5 run execute as @a[tag=ench_particle] at @s positioned ~0.77 ~1 ~-0.21 run function sgp.cosmetics:particles/ench_spawn
execute if score #ench_particle sgp.dummy matches 6 run execute as @a[tag=ench_particle] at @s positioned ~0.8 ~1 ~ run function sgp.cosmetics:particles/ench_spawn
execute if score #ench_particle sgp.dummy matches 7 run execute as @a[tag=ench_particle] at @s positioned ~0.77 ~1 ~0.21 run function sgp.cosmetics:particles/ench_spawn
execute if score #ench_particle sgp.dummy matches 8 run execute as @a[tag=ench_particle] at @s positioned ~0.69 ~1 ~0.4 run function sgp.cosmetics:particles/ench_spawn
execute if score #ench_particle sgp.dummy matches 9 run execute as @a[tag=ench_particle] at @s positioned ~0.57 ~1 ~0.57 run function sgp.cosmetics:particles/ench_spawn
execute if score #ench_particle sgp.dummy matches 10 run execute as @a[tag=ench_particle] at @s positioned ~0.4 ~1 ~0.69 run function sgp.cosmetics:particles/ench_spawn
execute if score #ench_particle sgp.dummy matches 11 run execute as @a[tag=ench_particle] at @s positioned ~0.21 ~1 ~0.77 run function sgp.cosmetics:particles/ench_spawn
execute if score #ench_particle sgp.dummy matches 12 run execute as @a[tag=ench_particle] at @s positioned ~0 ~1 ~0.8 run function sgp.cosmetics:particles/ench_spawn
execute if score #ench_particle sgp.dummy matches 13 run execute as @a[tag=ench_particle] at @s positioned ~-0.21 ~1 ~0.77 run function sgp.cosmetics:particles/ench_spawn
execute if score #ench_particle sgp.dummy matches 14 run execute as @a[tag=ench_particle] at @s positioned ~-0.4 ~1 ~0.69 run function sgp.cosmetics:particles/ench_spawn
execute if score #ench_particle sgp.dummy matches 15 run execute as @a[tag=ench_particle] at @s positioned ~-0.57 ~1 ~0.57 run function sgp.cosmetics:particles/ench_spawn
execute if score #ench_particle sgp.dummy matches 16 run execute as @a[tag=ench_particle] at @s positioned ~-0.69 ~1 ~0.4 run function sgp.cosmetics:particles/ench_spawn
execute if score #ench_particle sgp.dummy matches 17 run execute as @a[tag=ench_particle] at @s positioned ~-0.77 ~1 ~0.21 run function sgp.cosmetics:particles/ench_spawn
execute if score #ench_particle sgp.dummy matches 18 run execute as @a[tag=ench_particle] at @s positioned ~-0.8 ~1 ~ run function sgp.cosmetics:particles/ench_spawn
execute if score #ench_particle sgp.dummy matches 19 run execute as @a[tag=ench_particle] at @s positioned ~-0.77 ~1 ~-0.21 run function sgp.cosmetics:particles/ench_spawn
execute if score #ench_particle sgp.dummy matches 20 run execute as @a[tag=ench_particle] at @s positioned ~-0.69 ~1 ~-0.4 run function sgp.cosmetics:particles/ench_spawn
execute if score #ench_particle sgp.dummy matches 21 run execute as @a[tag=ench_particle] at @s positioned ~-0.57 ~1 ~-0.57 run function sgp.cosmetics:particles/ench_spawn
execute if score #ench_particle sgp.dummy matches 22 run execute as @a[tag=ench_particle] at @s positioned ~-0.4 ~1 ~-0.69 run function sgp.cosmetics:particles/ench_spawn
execute if score #ench_particle sgp.dummy matches 23 run execute as @a[tag=ench_particle] at @s positioned ~-0.21 ~1 ~-0.77 run function sgp.cosmetics:particles/ench_spawn
execute if score #ench_particle sgp.dummy matches 24 run execute as @a[tag=ench_particle] at @s positioned ~ ~1 ~-0.8 run function sgp.cosmetics:particles/ench_spawn

execute if score #ench_particle sgp.dummy matches 24 run scoreboard players set #ench_particle sgp.dummy 0
scoreboard players add #ench_particle sgp.dummy 1