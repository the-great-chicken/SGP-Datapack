#> sgp.kits:abilities/rays/update_ray_block_dispatch
#
# Skip Bookshelf entirely when a beam is proven clear of blocking blocks.

execute if entity @s[tag=sgp.ray_cardinal] \
    if function sgp.kits:abilities/rays/cardinal_clear \
        run return run function sgp.kits:abilities/rays/update_ray_clear with storage sgp:rays prediction

execute if entity @s[tag=!sgp.ray_cardinal] \
    if function sgp.kits:abilities/rays/diagonal_clear \
        run return run function sgp.kits:abilities/rays/update_ray_clear with storage sgp:rays prediction
function sgp.kits:abilities/rays/update_ray_block_only with storage sgp:rays prediction
