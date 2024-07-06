#> sgp.cosmetics:particles/individual/smoke_spawn
# 
# Summons the Smoke particles at the current coordinates, depending on
# the particle cloak's weight

execute as @a[tag=sgp.smoke_particle,tag=sgp.light_particle] at @s run particle minecraft:smoke ~ ~0.5 ~ 0.2 0.4 0.2 0.02 3
execute as @a[tag=sgp.smoke_particle,tag=sgp.medium_particle] at @s run particle minecraft:smoke ~ ~0.5 ~ 0.2 0.4 0.2 0.02 10
execute as @a[tag=sgp.smoke_particle,tag=sgp.heavy_particle] at @s run particle minecraft:smoke ~ ~0.5 ~ 0.2 0.4 0.2 0.02 20
execute as @a[tag=sgp.smoke_particle,tag=sgp.super_heavy_particle] at @s run particle minecraft:smoke ~ ~0.5 ~ 0.2 0.4 0.2 0.02 50