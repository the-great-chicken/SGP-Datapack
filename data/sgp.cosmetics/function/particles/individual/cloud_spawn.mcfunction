#> sgp.cosmetics:particles/individual/cloud_spawn
# 
# Summons the Cloud particles at the current coordinates, depending on
# the particle cloak's weight

execute as @a[tag=sgp.particle.cloud,tag=sgp.intensity.light,predicate=!sgp.misc:is_sneaking] at @s run particle minecraft:cloud ~ ~2.2 ~ 0.18 0 0.18 0 2
execute as @a[tag=sgp.particle.cloud,tag=sgp.intensity.medium,predicate=!sgp.misc:is_sneaking] at @s run particle minecraft:cloud ~ ~2.2 ~ 0.21 0 0.21 0 5
execute as @a[tag=sgp.particle.cloud,tag=sgp.intensity.heavy,predicate=!sgp.misc:is_sneaking] at @s run particle minecraft:cloud ~ ~2.2 ~ 0.25 0 0.25 0 10
execute as @a[tag=sgp.particle.cloud,tag=sgp.intensity.super_heavy,predicate=!sgp.misc:is_sneaking] at @s run particle minecraft:cloud ~ ~2.3 ~ 0.3 0 0.3 0 25

execute as @a[tag=sgp.particle.cloud,tag=sgp.intensity.light,predicate=sgp.misc:is_sneaking] at @s run particle minecraft:cloud ~ ~1.8 ~ 0.18 0 0.18 0 2
execute as @a[tag=sgp.particle.cloud,tag=sgp.intensity.medium,predicate=sgp.misc:is_sneaking] at @s run particle minecraft:cloud ~ ~1.8 ~ 0.21 0 0.21 0 5
execute as @a[tag=sgp.particle.cloud,tag=sgp.intensity.heavy,predicate=sgp.misc:is_sneaking] at @s run particle minecraft:cloud ~ ~1.8 ~ 0.25 0 0.25 0 10
execute as @a[tag=sgp.particle.cloud,tag=sgp.intensity.super_heavy,predicate=sgp.misc:is_sneaking] at @s run particle minecraft:cloud ~ ~1.9 ~ 0.3 0 0.3 0 25