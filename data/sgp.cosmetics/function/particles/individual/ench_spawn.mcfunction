#> sgp.cosmetics:particles/individual/ench_spawn
# 
# Summons the Sharpness particles at the current coordinates, depending on
# the particle cloak's weight

execute if entity @s[tag=sgp.intensity.light] run particle minecraft:enchanted_hit ~ ~ ~ 0 0 0 0 1
execute if entity @s[tag=sgp.intensity.medium] run particle minecraft:enchanted_hit ~ ~ ~ 0.05 0 0.05 0 2
execute if entity @s[tag=sgp.intensity.heavy] run particle minecraft:enchanted_hit ~ ~ ~ 0.05 0 0.05 0 2
execute if entity @s[tag=sgp.intensity.heavy] facing entity @s eyes run particle minecraft:enchanted_hit ^ ^-1 ^1.25 0.05 0 0.05 0 2
execute if entity @s[tag=sgp.intensity.super_heavy] run particle minecraft:enchanted_hit ~ ~ ~ 0.05 0 0.05 0 2
execute if entity @s[tag=sgp.intensity.super_heavy] facing entity @s eyes run particle minecraft:enchanted_hit ^ ^-1 ^1.25 0.05 0 0.05 0 2
execute if entity @s[tag=sgp.intensity.super_heavy] run particle minecraft:enchanted_hit ~ ~ ~ 0.05 0 0.05 0.25 1
execute if entity @s[tag=sgp.intensity.super_heavy] facing entity @s eyes run particle minecraft:enchanted_hit ^ ^-1 ^1.25 0.05 0 0.05 0.25 1