#> sgp.kits:abilities/rays/has_target
#
# Return success when a tagged target can intersect this beam.
# Overlapping selector AABBs conservatively cover the complete 16-block ray segment.
# Their guaranteed local coverage is -0.25..0.75, 0.70..1.70, 1.65..6.75, 6.70..11.80, and 11.75..16.15.

execute positioned ^ ^ ^0.25 positioned ~-0.5 ~-0.5 ~-0.5 \
    if entity @a[tag=sgp.ray_target,dx=0,dy=0,dz=0,limit=1] \
        run return 1

execute positioned ^ ^ ^1.2 positioned ~-0.5 ~-0.5 ~-0.5 \
    if entity @a[tag=sgp.ray_target,dx=0,dy=0,dz=0,limit=1] \
        run return 1

execute positioned ^ ^ ^4.2 positioned ~-2.55 ~-0.5 ~-2.55 \
    if entity @a[tag=sgp.ray_target,dx=4.1,dy=0,dz=4.1,limit=1] \
        run return 1

execute positioned ^ ^ ^9.25 positioned ~-2.55 ~-0.5 ~-2.55 \
    if entity @a[tag=sgp.ray_target,dx=4.1,dy=0,dz=4.1,limit=1] \
        run return 1

execute positioned ^ ^ ^13.95 positioned ~-2.2 ~-0.5 ~-2.2 \
    if entity @a[tag=sgp.ray_target,dx=3.4,dy=0,dz=3.4,limit=1] \
        run return 1

return 0
