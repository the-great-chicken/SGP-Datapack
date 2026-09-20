#> sgp.kits:abilities/rays/update_ray_dispatch
#
# Select the block-only path per beam when no tagged target can intersect it.

execute unless function sgp.kits:abilities/rays/has_target \
    run return run function sgp.kits:abilities/rays/update_ray_block_only with storage sgp:rays prediction

function sgp.kits:abilities/rays/update_ray with storage sgp:rays prediction
