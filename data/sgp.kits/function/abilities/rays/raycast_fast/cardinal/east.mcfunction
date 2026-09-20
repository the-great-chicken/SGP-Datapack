#> sgp.kits:abilities/rays/raycast_fast/cardinal/east

# Corridor along +x: [0, 16] on the beam axis, one block wide and tall starting at the beam line.
execute as @a[tag=sgp.ray_target,dx=15,dy=0,dz=0] run function sgp.kits:abilities/rays/raycast_fast/cardinal/check_east
