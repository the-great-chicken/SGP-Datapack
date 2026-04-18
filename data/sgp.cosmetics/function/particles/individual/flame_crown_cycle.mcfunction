#> sgp.cosmetics:particles/individual/flame_crown_cycle
# 
# Cycles the Flame Crown particle cloak around a player, spawning them at the
# right coordinates each time

execute if score #flame_crown_particle sgp.dummy matches 16 run scoreboard players set #flame_crown_particle sgp.dummy 0
scoreboard players add #flame_crown_particle sgp.dummy 1

execute if score #flame_crown_particle sgp.dummy matches 1 as @a[tag=sgp.particle.flame_crown] at @s positioned ~0.35 ~2 ~ run function sgp.cosmetics:particles/individual/flame_crown_spawn
execute if score #flame_crown_particle sgp.dummy matches 2 as @a[tag=sgp.particle.flame_crown,tag=!sgp.intensity.light] at @s positioned ~0.32 ~2 ~0.13 run function sgp.cosmetics:particles/individual/flame_crown_spawn
execute if score #flame_crown_particle sgp.dummy matches 3 as @a[tag=sgp.particle.flame_crown] at @s positioned ~0.25 ~2 ~0.25 run function sgp.cosmetics:particles/individual/flame_crown_spawn
execute if score #flame_crown_particle sgp.dummy matches 4 as @a[tag=sgp.particle.flame_crown,tag=!sgp.intensity.light] at @s positioned ~0.13 ~2 ~0.32 run function sgp.cosmetics:particles/individual/flame_crown_spawn
execute if score #flame_crown_particle sgp.dummy matches 5 as @a[tag=sgp.particle.flame_crown] at @s positioned ~ ~2 ~0.35 run function sgp.cosmetics:particles/individual/flame_crown_spawn
execute if score #flame_crown_particle sgp.dummy matches 6 as @a[tag=sgp.particle.flame_crown,tag=!sgp.intensity.light] at @s positioned ~-0.13 ~2 ~0.32 run function sgp.cosmetics:particles/individual/flame_crown_spawn
execute if score #flame_crown_particle sgp.dummy matches 7 as @a[tag=sgp.particle.flame_crown] at @s positioned ~-0.25 ~2 ~0.25 run function sgp.cosmetics:particles/individual/flame_crown_spawn
execute if score #flame_crown_particle sgp.dummy matches 8 as @a[tag=sgp.particle.flame_crown,tag=!sgp.intensity.light] at @s positioned ~-0.32 ~2 ~0.13 run function sgp.cosmetics:particles/individual/flame_crown_spawn
execute if score #flame_crown_particle sgp.dummy matches 9 as @a[tag=sgp.particle.flame_crown] at @s positioned ~-0.35 ~2 ~ run function sgp.cosmetics:particles/individual/flame_crown_spawn
execute if score #flame_crown_particle sgp.dummy matches 10 as @a[tag=sgp.particle.flame_crown,tag=!sgp.intensity.light] at @s positioned ~-0.32 ~2 ~-0.13 run function sgp.cosmetics:particles/individual/flame_crown_spawn
execute if score #flame_crown_particle sgp.dummy matches 11 as @a[tag=sgp.particle.flame_crown] at @s positioned ~-0.25 ~2 ~-0.25 run function sgp.cosmetics:particles/individual/flame_crown_spawn
execute if score #flame_crown_particle sgp.dummy matches 12 as @a[tag=sgp.particle.flame_crown,tag=!sgp.intensity.light] at @s positioned ~-0.13 ~2 ~-0.32 run function sgp.cosmetics:particles/individual/flame_crown_spawn
execute if score #flame_crown_particle sgp.dummy matches 13 as @a[tag=sgp.particle.flame_crown] at @s positioned ~ ~2 ~-0.35 run function sgp.cosmetics:particles/individual/flame_crown_spawn
execute if score #flame_crown_particle sgp.dummy matches 14 as @a[tag=sgp.particle.flame_crown,tag=!sgp.intensity.light] at @s positioned ~0.13 ~2 ~-0.32 run function sgp.cosmetics:particles/individual/flame_crown_spawn
execute if score #flame_crown_particle sgp.dummy matches 15 as @a[tag=sgp.particle.flame_crown] at @s positioned ~0.25 ~2 ~-0.25 run function sgp.cosmetics:particles/individual/flame_crown_spawn
execute if score #flame_crown_particle sgp.dummy matches 16 as @a[tag=sgp.particle.flame_crown,tag=!sgp.intensity.light] at @s positioned ~0.32 ~2 ~-0.13 run function sgp.cosmetics:particles/individual/flame_crown_spawn

execute if score #flame_crown_particle sgp.dummy matches 1 as @a[tag=sgp.particle.flame_crown,tag=sgp.intensity.super_heavy,predicate=sgp.misc:is_sneaking] at @s run particle minecraft:flame ~0.5 ~1.5 ~ 0 0.6 0 0 20
execute if score #flame_crown_particle sgp.dummy matches 3 as @a[tag=sgp.particle.flame_crown,tag=sgp.intensity.super_heavy,predicate=sgp.misc:is_sneaking] at @s run particle minecraft:flame ~0.35 ~1.5 ~0.35 0 0.6 0 0 20
execute if score #flame_crown_particle sgp.dummy matches 5 as @a[tag=sgp.particle.flame_crown,tag=sgp.intensity.super_heavy,predicate=sgp.misc:is_sneaking] at @s run particle minecraft:flame ~ ~1.5 ~0.5 0 0.6 0 0 20
execute if score #flame_crown_particle sgp.dummy matches 7 as @a[tag=sgp.particle.flame_crown,tag=sgp.intensity.super_heavy,predicate=sgp.misc:is_sneaking] at @s run particle minecraft:flame ~-0.35 ~1.5 ~0.35 0 0.6 0 0 20
execute if score #flame_crown_particle sgp.dummy matches 9 as @a[tag=sgp.particle.flame_crown,tag=sgp.intensity.super_heavy,predicate=sgp.misc:is_sneaking] at @s run particle minecraft:flame ~-0.5 ~1.5 ~ 0 0.6 0 0 20
execute if score #flame_crown_particle sgp.dummy matches 11 as @a[tag=sgp.particle.flame_crown,tag=sgp.intensity.super_heavy,predicate=sgp.misc:is_sneaking] at @s run particle minecraft:flame ~-0.35 ~1.5 ~-0.35 0 0.6 0 0 20
execute if score #flame_crown_particle sgp.dummy matches 13 as @a[tag=sgp.particle.flame_crown,tag=sgp.intensity.super_heavy,predicate=sgp.misc:is_sneaking] at @s run particle minecraft:flame ~ ~1.5 ~-0.5 0 0.6 0 0 20
execute if score #flame_crown_particle sgp.dummy matches 15 as @a[tag=sgp.particle.flame_crown,tag=sgp.intensity.super_heavy,predicate=sgp.misc:is_sneaking] at @s run particle minecraft:flame ~0.35 ~1.5 ~-0.35 0 0.6 0 0 20