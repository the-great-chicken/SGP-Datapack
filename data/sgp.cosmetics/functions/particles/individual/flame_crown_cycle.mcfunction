#> sgp.cosmetics:particles/individual/flame_crown_cycle
# 
# Cycles the Flame Crown particle cloak around a player, spawning them at the
# right coordinates each time

execute if score #flame_crown_particle sgp.dummy matches 1 run execute as @a[tag=flame_crown_particle] at @s positioned ~0.35 ~2 ~ run function sgp.cosmetics:particles/individual/flame_crown_spawn
execute if score #flame_crown_particle sgp.dummy matches 2 run execute as @a[tag=flame_crown_particle,tag=!light_particle] at @s positioned ~0.32 ~2 ~0.13 run function sgp.cosmetics:particles/individual/flame_crown_spawn
execute if score #flame_crown_particle sgp.dummy matches 3 run execute as @a[tag=flame_crown_particle] at @s positioned ~0.25 ~2 ~0.25 run function sgp.cosmetics:particles/individual/flame_crown_spawn
execute if score #flame_crown_particle sgp.dummy matches 4 run execute as @a[tag=flame_crown_particle,tag=!light_particle] at @s positioned ~0.13 ~2 ~0.32 run function sgp.cosmetics:particles/individual/flame_crown_spawn
execute if score #flame_crown_particle sgp.dummy matches 5 run execute as @a[tag=flame_crown_particle] at @s positioned ~ ~2 ~0.35 run function sgp.cosmetics:particles/individual/flame_crown_spawn
execute if score #flame_crown_particle sgp.dummy matches 6 run execute as @a[tag=flame_crown_particle,tag=!light_particle] at @s positioned ~-0.13 ~2 ~0.32 run function sgp.cosmetics:particles/individual/flame_crown_spawn
execute if score #flame_crown_particle sgp.dummy matches 7 run execute as @a[tag=flame_crown_particle] at @s positioned ~-0.25 ~2 ~0.25 run function sgp.cosmetics:particles/individual/flame_crown_spawn
execute if score #flame_crown_particle sgp.dummy matches 8 run execute as @a[tag=flame_crown_particle,tag=!light_particle] at @s positioned ~-0.32 ~2 ~0.13 run function sgp.cosmetics:particles/individual/flame_crown_spawn
execute if score #flame_crown_particle sgp.dummy matches 9 run execute as @a[tag=flame_crown_particle] at @s positioned ~-0.35 ~2 ~ run function sgp.cosmetics:particles/individual/flame_crown_spawn
execute if score #flame_crown_particle sgp.dummy matches 10 run execute as @a[tag=flame_crown_particle,tag=!light_particle] at @s positioned ~-0.32 ~2 ~-0.13 run function sgp.cosmetics:particles/individual/flame_crown_spawn
execute if score #flame_crown_particle sgp.dummy matches 11 run execute as @a[tag=flame_crown_particle] at @s positioned ~-0.25 ~2 ~-0.25 run function sgp.cosmetics:particles/individual/flame_crown_spawn
execute if score #flame_crown_particle sgp.dummy matches 12 run execute as @a[tag=flame_crown_particle,tag=!light_particle] at @s positioned ~-0.13 ~2 ~-0.32 run function sgp.cosmetics:particles/individual/flame_crown_spawn
execute if score #flame_crown_particle sgp.dummy matches 13 run execute as @a[tag=flame_crown_particle] at @s positioned ~ ~2 ~-0.35 run function sgp.cosmetics:particles/individual/flame_crown_spawn
execute if score #flame_crown_particle sgp.dummy matches 14 run execute as @a[tag=flame_crown_particle,tag=!light_particle] at @s positioned ~0.13 ~2 ~-0.32 run function sgp.cosmetics:particles/individual/flame_crown_spawn
execute if score #flame_crown_particle sgp.dummy matches 15 run execute as @a[tag=flame_crown_particle] at @s positioned ~0.25 ~2 ~-0.25 run function sgp.cosmetics:particles/individual/flame_crown_spawn
execute if score #flame_crown_particle sgp.dummy matches 16 run execute as @a[tag=flame_crown_particle,tag=!light_particle] at @s positioned ~0.32 ~2 ~-0.13 run function sgp.cosmetics:particles/individual/flame_crown_spawn

execute if score #flame_crown_particle sgp.dummy matches 1 run execute as @a[tag=flame_crown_particle,tag=super_heavy_particle,scores={sgp.sneak_particle=1}] at @s run particle minecraft:flame ~0.5 ~1.5 ~ 0 0.6 0 0 20
execute if score #flame_crown_particle sgp.dummy matches 3 run execute as @a[tag=flame_crown_particle,tag=super_heavy_particle,scores={sgp.sneak_particle=1}] at @s run particle minecraft:flame ~0.35 ~1.5 ~0.35 0 0.6 0 0 20
execute if score #flame_crown_particle sgp.dummy matches 5 run execute as @a[tag=flame_crown_particle,tag=super_heavy_particle,scores={sgp.sneak_particle=1}] at @s run particle minecraft:flame ~ ~1.5 ~0.5 0 0.6 0 0 20
execute if score #flame_crown_particle sgp.dummy matches 7 run execute as @a[tag=flame_crown_particle,tag=super_heavy_particle,scores={sgp.sneak_particle=1}] at @s run particle minecraft:flame ~-0.35 ~1.5 ~0.35 0 0.6 0 0 20
execute if score #flame_crown_particle sgp.dummy matches 9 run execute as @a[tag=flame_crown_particle,tag=super_heavy_particle,scores={sgp.sneak_particle=1}] at @s run particle minecraft:flame ~-0.5 ~1.5 ~ 0 0.6 0 0 20
execute if score #flame_crown_particle sgp.dummy matches 11 run execute as @a[tag=flame_crown_particle,tag=super_heavy_particle,scores={sgp.sneak_particle=1}] at @s run particle minecraft:flame ~-0.35 ~1.5 ~-0.35 0 0.6 0 0 20
execute if score #flame_crown_particle sgp.dummy matches 13 run execute as @a[tag=flame_crown_particle,tag=super_heavy_particle,scores={sgp.sneak_particle=1}] at @s run particle minecraft:flame ~ ~1.5 ~-0.5 0 0.6 0 0 20
execute if score #flame_crown_particle sgp.dummy matches 15 run execute as @a[tag=flame_crown_particle,tag=super_heavy_particle,scores={sgp.sneak_particle=1}] at @s run particle minecraft:flame ~0.35 ~1.5 ~-0.35 0 0.6 0 0 20


execute if score #flame_crown_particle sgp.dummy matches 16 run scoreboard players set #flame_crown_particle sgp.dummy 0
scoreboard players add #flame_crown_particle sgp.dummy 1

scoreboard players set @a[tag=flame_crown_particle] sgp.sneak_particle 0