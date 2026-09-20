#> sgp.kits:abilities/rays/raycast_fast/cardinal/north

# Corridor along -z: [0, 16] on the beam axis, one block wide and tall starting at the beam line.
execute positioned ~ ~ ~-16 as @a[tag=sgp.ray_target,dx=0,dy=0,dz=15] run function sgp.kits:abilities/rays/raycast_fast/cardinal/check_north
