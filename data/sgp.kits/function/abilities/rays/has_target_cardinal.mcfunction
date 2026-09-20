#> sgp.kits:abilities/rays/has_target_cardinal
#
# Cardinal beams fit inside one conservative selector AABB.

execute if entity @s[tag=sgp.south] \
    positioned ~-0.5 ~-0.5 ~-0.5 \
        if entity @a[tag=sgp.ray_target,dx=0,dy=0,dz=16,limit=1] run return 1

execute if entity @s[tag=sgp.north] \
    positioned ~-0.5 ~-0.5 ~-0.5 \
        if entity @a[tag=sgp.ray_target,dx=0,dy=0,dz=-16,limit=1] run return 1

execute if entity @s[tag=sgp.east] \
    positioned ~-0.5 ~-0.5 ~-0.5 \
        if entity @a[tag=sgp.ray_target,dx=16,dy=0,dz=0,limit=1] run return 1

execute if entity @s[tag=sgp.west] \
    positioned ~-0.5 ~-0.5 ~-0.5 \
        if entity @a[tag=sgp.ray_target,dx=-16,dy=0,dz=0,limit=1] run return 1

return 0
