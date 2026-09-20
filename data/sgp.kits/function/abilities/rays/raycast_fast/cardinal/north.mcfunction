#> sgp.kits:abilities/rays/raycast_fast/cardinal/north

execute in minecraft:overworld positioned as @s as B5-0-0-0-1 \
    run function sgp.kits:abilities/rays/raycast_fast/cardinal/origin_z with storage bs:data raycast
execute positioned ~-0.01 ~-0.01 ~-0.99 \
    as @a[tag=sgp.ray_target,sort=nearest,dx=0,dy=0,dz=-15.02] \
    positioned ~0.01 ~0.01 ~0.99 \
        run function sgp.kits:abilities/rays/raycast_fast/cardinal/check_north
