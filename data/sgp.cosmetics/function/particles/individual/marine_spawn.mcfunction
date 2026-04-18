#> sgp.cosmetics:particles/individual/marine_spawn
# 
# Summons the Marine particles at the current coordinates, depending on
# the particle cloak's weight

execute as @a[tag=sgp.particle.marine,tag=sgp.intensity.light] at @s run particle minecraft:dolphin ~ ~0.5 ~ 0.2 0.4 0.2 0.02 2
execute as @a[tag=sgp.particle.marine,tag=sgp.intensity.light] at @s run particle minecraft:falling_water ~ ~0.5 ~ 0.2 0.4 0.2 0.02 2
execute as @a[tag=sgp.particle.marine,tag=sgp.intensity.light] at @s run particle minecraft:underwater ~ ~0.5 ~ 0.2 0.4 0.2 0.02 2
execute as @a[tag=sgp.particle.marine,tag=sgp.intensity.light] at @s run particle minecraft:cloud ~ ~0.5 ~ 0.2 0.4 0.2 0.02 1

execute as @a[tag=sgp.particle.marine,tag=sgp.intensity.medium] at @s run particle minecraft:dolphin ~ ~0.5 ~ 0.2 0.4 0.2 0.02 5
execute as @a[tag=sgp.particle.marine,tag=sgp.intensity.medium] at @s run particle minecraft:falling_water ~ ~0.5 ~ 0.2 0.4 0.2 0.02 5
execute as @a[tag=sgp.particle.marine,tag=sgp.intensity.medium] at @s run particle minecraft:underwater ~ ~0.5 ~ 0.2 0.4 0.2 0.02 5
execute as @a[tag=sgp.particle.marine,tag=sgp.intensity.medium] at @s run particle minecraft:cloud ~ ~0.5 ~ 0.2 0.4 0.2 0.02 2

execute as @a[tag=sgp.particle.marine,tag=sgp.intensity.heavy] at @s run particle minecraft:dolphin ~ ~0.5 ~ 0.2 0.4 0.2 0.02 5
execute as @a[tag=sgp.particle.marine,tag=sgp.intensity.heavy] at @s run particle minecraft:falling_water ~ ~0.5 ~ 0.2 0.4 0.2 0.02 5
execute as @a[tag=sgp.particle.marine,tag=sgp.intensity.heavy] at @s run particle minecraft:underwater ~ ~0.5 ~ 0.2 0.4 0.2 0.02 5
execute as @a[tag=sgp.particle.marine,tag=sgp.intensity.heavy] at @s run particle minecraft:cloud ~ ~0.5 ~ 0.2 0.4 0.2 0.02 4

execute as @a[tag=sgp.particle.marine,tag=sgp.intensity.super_heavy] at @s run particle minecraft:dolphin ~ ~0.5 ~ 0.2 0.4 0.2 0.02 10
execute as @a[tag=sgp.particle.marine,tag=sgp.intensity.super_heavy] at @s run particle minecraft:falling_water ~ ~0.5 ~ 0.2 0.4 0.2 0.02 10
execute as @a[tag=sgp.particle.marine,tag=sgp.intensity.super_heavy] at @s run particle minecraft:underwater ~ ~0.5 ~ 0.2 0.4 0.2 0.02 10
execute as @a[tag=sgp.particle.marine,tag=sgp.intensity.super_heavy] at @s run particle minecraft:angry_villager ~ ~-0.5 ~ 0.2 0.4 0.2 0 4