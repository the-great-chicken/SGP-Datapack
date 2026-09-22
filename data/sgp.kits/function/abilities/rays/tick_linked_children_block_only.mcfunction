#> sgp.kits:abilities/rays/tick_linked_children_block_only
# No damageable player can intersect a beam, so use the block-only dispatcher.

# Teleporting beyond the 10-block tracking range intentionally stops Rays; cleanup removes the abandoned beams.
execute as @e[distance=..10,tag=sgp.ray,predicate=bs.link:link_equal,limit=8,type=item_display] \
    positioned ~ ~0.6 ~ rotated as @s \
        run function sgp.kits:abilities/rays/update_ray_block_dispatch
