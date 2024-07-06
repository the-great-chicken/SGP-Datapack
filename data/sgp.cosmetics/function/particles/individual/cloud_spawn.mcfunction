#> sgp.cosmetics:particles/individual/cloud_spawn
# 
# Summons the Cloud particles at the current coordinates, depending on
# the particle cloak's weight

execute as @a[tag=sgp.cloud_particle,tag=sgp.light_particle,scores={sgp.sneak_particle=0}] at @s run particle minecraft:cloud ~ ~2.2 ~ 0.18 0 0.18 0 2
execute as @a[tag=sgp.cloud_particle,tag=sgp.medium_particle,scores={sgp.sneak_particle=0}] at @s run particle minecraft:cloud ~ ~2.2 ~ 0.21 0 0.21 0 5
execute as @a[tag=sgp.cloud_particle,tag=sgp.heavy_particle,scores={sgp.sneak_particle=0}] at @s run particle minecraft:cloud ~ ~2.2 ~ 0.25 0 0.25 0 10
execute as @a[tag=sgp.cloud_particle,tag=sgp.super_heavy_particle,scores={sgp.sneak_particle=0}] at @s run particle minecraft:cloud ~ ~2.3 ~ 0.3 0 0.3 0 25

execute as @a[tag=sgp.cloud_particle,tag=sgp.light_particle,scores={sgp.sneak_particle=1..}] at @s run particle minecraft:cloud ~ ~1.8 ~ 0.18 0 0.18 0 2
execute as @a[tag=sgp.cloud_particle,tag=sgp.medium_particle,scores={sgp.sneak_particle=1..}] at @s run particle minecraft:cloud ~ ~1.8 ~ 0.21 0 0.21 0 5
execute as @a[tag=sgp.cloud_particle,tag=sgp.heavy_particle,scores={sgp.sneak_particle=1..}] at @s run particle minecraft:cloud ~ ~1.8 ~ 0.25 0 0.25 0 10
execute as @a[tag=sgp.cloud_particle,tag=sgp.super_heavy_particle,scores={sgp.sneak_particle=1..}] at @s run particle minecraft:cloud ~ ~1.9 ~ 0.3 0 0.3 0 25

scoreboard players set @a[tag=sgp.cloud_particle] sgp.sneak_particle 0