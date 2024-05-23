execute if entity @s[tag=light_particle] run particle minecraft:enchanted_hit ~ ~ ~ 0 0 0 0 1
execute if entity @s[tag=medium_particle] run particle minecraft:enchanted_hit ~ ~ ~ 0.05 0 0.05 0 2
execute if entity @s[tag=heavy_particle] run particle minecraft:enchanted_hit ~ ~ ~ 0.05 0 0.05 0 2
execute if entity @s[tag=heavy_particle] facing entity @s eyes run particle minecraft:enchanted_hit ^ ^-1 ^1.25 0.05 0 0.05 0 2
execute if entity @s[tag=super_heavy_particle] run particle minecraft:enchanted_hit ~ ~ ~ 0.05 0 0.05 0 2
execute if entity @s[tag=super_heavy_particle] facing entity @s eyes run particle minecraft:enchanted_hit ^ ^-1 ^1.25 0.05 0 0.05 0 2
execute if entity @s[tag=super_heavy_particle] run particle minecraft:enchanted_hit ~ ~ ~ 0.05 0 0.05 0.25 1
execute if entity @s[tag=super_heavy_particle] facing entity @s eyes run particle minecraft:enchanted_hit ^ ^-1 ^1.25 0.05 0 0.05 0.25 1