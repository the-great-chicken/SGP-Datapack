#> sgp.cosmetics:particles/individual/flame_crown_spawn
# 
# Summons the Flame Crown particles at the current coordinates, depending on
# the particle cloak's weight

execute if entity @s[tag=sgp.intensity.light,predicate=!sgp.misc:is_sneaking] run particle minecraft:flame ~ ~ ~ 0 0 0 0 1
execute if entity @s[tag=sgp.intensity.medium,predicate=!sgp.misc:is_sneaking] run particle minecraft:flame ~ ~ ~ 0 0 0 0 1
execute if entity @s[tag=sgp.intensity.heavy,predicate=!sgp.misc:is_sneaking] run particle minecraft:flame ~ ~ ~ 0.03 0 0.03 0 2
execute if entity @s[tag=sgp.intensity.super_heavy,predicate=!sgp.misc:is_sneaking] run particle minecraft:flame ~ ~ ~ 0 0 0 0 1

execute if entity @s[tag=sgp.intensity.light,predicate=sgp.misc:is_sneaking] run particle minecraft:flame ~ ~-0.4 ~ 0 0 0 0 1
execute if entity @s[tag=sgp.intensity.medium,predicate=sgp.misc:is_sneaking] run particle minecraft:flame ~ ~-0.4 ~ 0 0 0 0 1
execute if entity @s[tag=sgp.intensity.heavy,predicate=sgp.misc:is_sneaking] run particle minecraft:flame ~ ~-0.4 ~ 0.03 0 0.03 0 2

scoreboard players operation #flame_crown_particle_even sgp.dummy = #flame_crown_particle sgp.dummy
scoreboard players operation #flame_crown_particle_even sgp.dummy %= 3 sgp.dummy

execute if entity @s[tag=sgp.intensity.super_heavy,predicate=!sgp.misc:is_sneaking] if score #flame_crown_particle_even sgp.dummy matches 0 run particle flame ~ ~0.2 ~ 0 0.05 0 0 3