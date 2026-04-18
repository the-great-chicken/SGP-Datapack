#> sgp.cosmetics:particles/individual/smoke_spawn
# 
# Summons the Smoke particles at the current coordinates, depending on
# the particle cloak's weight

execute as @a[tag=sgp.particle.smoke,tag=sgp.intensity.light] at @s run particle minecraft:smoke ~ ~0.5 ~ 0.2 0.4 0.2 0.02 3
execute as @a[tag=sgp.particle.smoke,tag=sgp.intensity.medium] at @s run particle minecraft:smoke ~ ~0.5 ~ 0.2 0.4 0.2 0.02 10
execute as @a[tag=sgp.particle.smoke,tag=sgp.intensity.heavy] at @s run particle minecraft:smoke ~ ~0.5 ~ 0.2 0.4 0.2 0.02 20
execute as @a[tag=sgp.particle.smoke,tag=sgp.intensity.super_heavy] at @s run particle minecraft:smoke ~ ~0.5 ~ 0.2 0.4 0.2 0.02 50