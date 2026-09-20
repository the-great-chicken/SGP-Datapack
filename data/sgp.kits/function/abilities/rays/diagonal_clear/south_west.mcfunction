#> sgp.kits:abilities/rays/diagonal_clear/south_west
#
# Band of voxels a south-west beam can cross, nearest first so a close wall exits early.

execute if block ~0 ~ ~0 #bs.hitbox:can_pass_through \
    if block ~0 ~ ~1 #bs.hitbox:can_pass_through \
    if block ~-1 ~ ~0 #bs.hitbox:can_pass_through \
    if block ~0 ~ ~2 #bs.hitbox:can_pass_through \
    if block ~-1 ~ ~1 #bs.hitbox:can_pass_through \
    if block ~-2 ~ ~0 #bs.hitbox:can_pass_through \
    if block ~-1 ~ ~2 #bs.hitbox:can_pass_through \
    if block ~-2 ~ ~1 #bs.hitbox:can_pass_through \
    if block ~-1 ~ ~3 #bs.hitbox:can_pass_through \
    if block ~-2 ~ ~2 #bs.hitbox:can_pass_through \
    if block ~-3 ~ ~1 #bs.hitbox:can_pass_through \
    if block ~-2 ~ ~3 #bs.hitbox:can_pass_through \
    if block ~-3 ~ ~2 #bs.hitbox:can_pass_through \
    if block ~-2 ~ ~4 #bs.hitbox:can_pass_through \
    if block ~-3 ~ ~3 #bs.hitbox:can_pass_through \
    if block ~-4 ~ ~2 #bs.hitbox:can_pass_through \
    if block ~-3 ~ ~4 #bs.hitbox:can_pass_through \
    if block ~-4 ~ ~3 #bs.hitbox:can_pass_through \
    if block ~-3 ~ ~5 #bs.hitbox:can_pass_through \
    if block ~-4 ~ ~4 #bs.hitbox:can_pass_through \
    if block ~-5 ~ ~3 #bs.hitbox:can_pass_through \
    if block ~-4 ~ ~5 #bs.hitbox:can_pass_through \
    if block ~-5 ~ ~4 #bs.hitbox:can_pass_through \
    if block ~-4 ~ ~6 #bs.hitbox:can_pass_through \
    if block ~-5 ~ ~5 #bs.hitbox:can_pass_through \
    if block ~-6 ~ ~4 #bs.hitbox:can_pass_through \
    if block ~-5 ~ ~6 #bs.hitbox:can_pass_through \
    if block ~-6 ~ ~5 #bs.hitbox:can_pass_through \
    if block ~-5 ~ ~7 #bs.hitbox:can_pass_through \
    if block ~-6 ~ ~6 #bs.hitbox:can_pass_through \
    if block ~-7 ~ ~5 #bs.hitbox:can_pass_through \
    if block ~-6 ~ ~7 #bs.hitbox:can_pass_through \
    if block ~-7 ~ ~6 #bs.hitbox:can_pass_through \
    if block ~-6 ~ ~8 #bs.hitbox:can_pass_through \
    if block ~-7 ~ ~7 #bs.hitbox:can_pass_through \
    if block ~-8 ~ ~6 #bs.hitbox:can_pass_through \
    if block ~-7 ~ ~8 #bs.hitbox:can_pass_through \
    if block ~-8 ~ ~7 #bs.hitbox:can_pass_through \
    if block ~-7 ~ ~9 #bs.hitbox:can_pass_through \
    if block ~-8 ~ ~8 #bs.hitbox:can_pass_through \
    if block ~-9 ~ ~7 #bs.hitbox:can_pass_through \
    if block ~-8 ~ ~9 #bs.hitbox:can_pass_through \
    if block ~-9 ~ ~8 #bs.hitbox:can_pass_through \
    if block ~-8 ~ ~10 #bs.hitbox:can_pass_through \
    if block ~-9 ~ ~9 #bs.hitbox:can_pass_through \
    if block ~-10 ~ ~8 #bs.hitbox:can_pass_through \
    if block ~-9 ~ ~10 #bs.hitbox:can_pass_through \
    if block ~-10 ~ ~9 #bs.hitbox:can_pass_through \
    if block ~-9 ~ ~11 #bs.hitbox:can_pass_through \
    if block ~-10 ~ ~10 #bs.hitbox:can_pass_through \
    if block ~-11 ~ ~9 #bs.hitbox:can_pass_through \
    if block ~-10 ~ ~11 #bs.hitbox:can_pass_through \
    if block ~-11 ~ ~10 #bs.hitbox:can_pass_through \
    if block ~-10 ~ ~12 #bs.hitbox:can_pass_through \
    if block ~-11 ~ ~11 #bs.hitbox:can_pass_through \
    if block ~-12 ~ ~10 #bs.hitbox:can_pass_through \
    if block ~-11 ~ ~12 #bs.hitbox:can_pass_through \
    if block ~-12 ~ ~11 #bs.hitbox:can_pass_through \
    if block ~-12 ~ ~12 #bs.hitbox:can_pass_through \
        run return 1

return 0
