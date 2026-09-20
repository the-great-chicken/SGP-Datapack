#> sgp.kits:abilities/rays/raycast_fast/cardinal/east

execute in minecraft:overworld as B5-0-0-0-1 \
    run function sgp.kits:abilities/rays/raycast_fast/cardinal/origin_x with storage sgp:rays origin
execute positioned ~-0.01 ~-0.01 ~-0.01 \
    as @a[tag=sgp.ray_target,sort=nearest,dx=15.02,dy=0,dz=0] \
    positioned ~0.01 ~0.01 ~0.01 \
        run function sgp.kits:abilities/rays/raycast_fast/cardinal/check_east
