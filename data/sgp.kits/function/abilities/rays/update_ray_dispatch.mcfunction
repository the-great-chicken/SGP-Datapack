#> sgp.kits:abilities/rays/update_ray_dispatch
#
# Select the cheapest exact collision path for this beam.

execute unless function sgp.kits:abilities/rays/has_target \
    run return run function sgp.kits:abilities/rays/update_ray_block_dispatch with storage sgp:rays prediction

execute if score #ray_hitbox_cache sgp.dummy matches 0 \
    run function sgp.kits:abilities/rays/cache_target_hitboxes

execute if entity @s[tag=sgp.ray_cardinal] \
    if function sgp.kits:abilities/rays/cardinal_clear \
        run return run function sgp.kits:abilities/rays/update_ray_entities_only with storage sgp:rays prediction

function sgp.kits:abilities/rays/update_ray with storage sgp:rays prediction
