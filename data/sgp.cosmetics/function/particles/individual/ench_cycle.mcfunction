#> sgp.cosmetics:particles/individual/ench_cycle
# 
# Cycles the Sharpness particle cloak around a player, spawning them at the
# right coordinates each time

execute if score #ench_particle sgp.dummy matches 24 run scoreboard players set #ench_particle sgp.dummy 0
scoreboard players add #ench_particle sgp.dummy 1

execute if score #ench_particle sgp.dummy matches 1 as @a[tag=sgp.particle.ench] at @s positioned ~0.21 ~1 ~-0.77 run function sgp.cosmetics:particles/individual/ench_spawn
execute if score #ench_particle sgp.dummy matches 2 as @a[tag=sgp.particle.ench] at @s positioned ~0.4 ~1 ~-0.69 run function sgp.cosmetics:particles/individual/ench_spawn
execute if score #ench_particle sgp.dummy matches 3 as @a[tag=sgp.particle.ench] at @s positioned ~0.57 ~1 ~-0.57 run function sgp.cosmetics:particles/individual/ench_spawn
execute if score #ench_particle sgp.dummy matches 4 as @a[tag=sgp.particle.ench] at @s positioned ~0.69 ~1 ~-0.4 run function sgp.cosmetics:particles/individual/ench_spawn
execute if score #ench_particle sgp.dummy matches 5 as @a[tag=sgp.particle.ench] at @s positioned ~0.77 ~1 ~-0.21 run function sgp.cosmetics:particles/individual/ench_spawn
execute if score #ench_particle sgp.dummy matches 6 as @a[tag=sgp.particle.ench] at @s positioned ~0.8 ~1 ~ run function sgp.cosmetics:particles/individual/ench_spawn
execute if score #ench_particle sgp.dummy matches 7 as @a[tag=sgp.particle.ench] at @s positioned ~0.77 ~1 ~0.21 run function sgp.cosmetics:particles/individual/ench_spawn
execute if score #ench_particle sgp.dummy matches 8 as @a[tag=sgp.particle.ench] at @s positioned ~0.69 ~1 ~0.4 run function sgp.cosmetics:particles/individual/ench_spawn
execute if score #ench_particle sgp.dummy matches 9 as @a[tag=sgp.particle.ench] at @s positioned ~0.57 ~1 ~0.57 run function sgp.cosmetics:particles/individual/ench_spawn
execute if score #ench_particle sgp.dummy matches 10 as @a[tag=sgp.particle.ench] at @s positioned ~0.4 ~1 ~0.69 run function sgp.cosmetics:particles/individual/ench_spawn
execute if score #ench_particle sgp.dummy matches 11 as @a[tag=sgp.particle.ench] at @s positioned ~0.21 ~1 ~0.77 run function sgp.cosmetics:particles/individual/ench_spawn
execute if score #ench_particle sgp.dummy matches 12 as @a[tag=sgp.particle.ench] at @s positioned ~0 ~1 ~0.8 run function sgp.cosmetics:particles/individual/ench_spawn
execute if score #ench_particle sgp.dummy matches 13 as @a[tag=sgp.particle.ench] at @s positioned ~-0.21 ~1 ~0.77 run function sgp.cosmetics:particles/individual/ench_spawn
execute if score #ench_particle sgp.dummy matches 14 as @a[tag=sgp.particle.ench] at @s positioned ~-0.4 ~1 ~0.69 run function sgp.cosmetics:particles/individual/ench_spawn
execute if score #ench_particle sgp.dummy matches 15 as @a[tag=sgp.particle.ench] at @s positioned ~-0.57 ~1 ~0.57 run function sgp.cosmetics:particles/individual/ench_spawn
execute if score #ench_particle sgp.dummy matches 16 as @a[tag=sgp.particle.ench] at @s positioned ~-0.69 ~1 ~0.4 run function sgp.cosmetics:particles/individual/ench_spawn
execute if score #ench_particle sgp.dummy matches 17 as @a[tag=sgp.particle.ench] at @s positioned ~-0.77 ~1 ~0.21 run function sgp.cosmetics:particles/individual/ench_spawn
execute if score #ench_particle sgp.dummy matches 18 as @a[tag=sgp.particle.ench] at @s positioned ~-0.8 ~1 ~ run function sgp.cosmetics:particles/individual/ench_spawn
execute if score #ench_particle sgp.dummy matches 19 as @a[tag=sgp.particle.ench] at @s positioned ~-0.77 ~1 ~-0.21 run function sgp.cosmetics:particles/individual/ench_spawn
execute if score #ench_particle sgp.dummy matches 20 as @a[tag=sgp.particle.ench] at @s positioned ~-0.69 ~1 ~-0.4 run function sgp.cosmetics:particles/individual/ench_spawn
execute if score #ench_particle sgp.dummy matches 21 as @a[tag=sgp.particle.ench] at @s positioned ~-0.57 ~1 ~-0.57 run function sgp.cosmetics:particles/individual/ench_spawn
execute if score #ench_particle sgp.dummy matches 22 as @a[tag=sgp.particle.ench] at @s positioned ~-0.4 ~1 ~-0.69 run function sgp.cosmetics:particles/individual/ench_spawn
execute if score #ench_particle sgp.dummy matches 23 as @a[tag=sgp.particle.ench] at @s positioned ~-0.21 ~1 ~-0.77 run function sgp.cosmetics:particles/individual/ench_spawn
execute if score #ench_particle sgp.dummy matches 24 as @a[tag=sgp.particle.ench] at @s positioned ~ ~1 ~-0.8 run function sgp.cosmetics:particles/individual/ench_spawn