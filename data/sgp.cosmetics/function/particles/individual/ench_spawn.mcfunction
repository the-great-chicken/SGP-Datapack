#> sgp.cosmetics:particles/individual/ench_spawn
# 
# Summons the Sharpness particles at the current coordinates, depending on
# the particle cloak's weight

execute if entity @s[tag=sgp.light_particle] run particle minecraft:enchanted_hit ~ ~ ~ 0 0 0 0 1
execute if entity @s[tag=sgp.medium_particle] run particle minecraft:enchanted_hit ~ ~ ~ 0.05 0 0.05 0 2
execute if entity @s[tag=sgp.heavy_particle] run particle minecraft:enchanted_hit ~ ~ ~ 0.05 0 0.05 0 2
execute if entity @s[tag=sgp.heavy_particle] facing entity @s eyes run particle minecraft:enchanted_hit ^ ^-1 ^1.25 0.05 0 0.05 0 2
execute if entity @s[tag=sgp.super_heavy_particle] run particle minecraft:enchanted_hit ~ ~ ~ 0.05 0 0.05 0 2
execute if entity @s[tag=sgp.super_heavy_particle] facing entity @s eyes run particle minecraft:enchanted_hit ^ ^-1 ^1.25 0.05 0 0.05 0 2
execute if entity @s[tag=sgp.super_heavy_particle] run particle minecraft:enchanted_hit ~ ~ ~ 0.05 0 0.05 0.25 1
execute if entity @s[tag=sgp.super_heavy_particle] facing entity @s eyes run particle minecraft:enchanted_hit ^ ^-1 ^1.25 0.05 0 0.05 0.25 1