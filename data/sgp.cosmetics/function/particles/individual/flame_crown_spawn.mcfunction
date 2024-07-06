#> sgp.cosmetics:particles/individual/flame_crown_spawn
# 
# Summons the Flame Crown particles at the current coordinates, depending on
# the particle cloak's weight

execute if entity @s[tag=sgp.light_particle,scores={sgp.sneak_particle=0}] run particle minecraft:flame ~ ~ ~ 0 0 0 0 1
execute if entity @s[tag=sgp.medium_particle,scores={sgp.sneak_particle=0}] run particle minecraft:flame ~ ~ ~ 0 0 0 0 1
execute if entity @s[tag=sgp.heavy_particle,scores={sgp.sneak_particle=0}] run particle minecraft:flame ~ ~ ~ 0.03 0 0.03 0 2
execute if entity @s[tag=sgp.super_heavy_particle,scores={sgp.sneak_particle=0}] run particle minecraft:flame ~ ~ ~ 0 0 0 0 1

execute if entity @s[tag=sgp.light_particle,scores={sgp.sneak_particle=1}] run particle minecraft:flame ~ ~-0.4 ~ 0 0 0 0 1
execute if entity @s[tag=sgp.medium_particle,scores={sgp.sneak_particle=1}] run particle minecraft:flame ~ ~-0.4 ~ 0 0 0 0 1
execute if entity @s[tag=sgp.heavy_particle,scores={sgp.sneak_particle=1}] run particle minecraft:flame ~ ~-0.4 ~ 0.03 0 0.03 0 2

scoreboard players operation #flame_crown_particle_even sgp.dummy = #flame_crown_particle sgp.dummy
scoreboard players operation #flame_crown_particle_even sgp.dummy %= 3 sgp.dummy

execute if entity @s[tag=sgp.super_heavy_particle,scores={sgp.sneak_particle=0}] if score #flame_crown_particle_even sgp.dummy matches 0 run particle flame ~ ~0.2 ~ 0 0.05 0 0 3