#> sgp.kits:abilities/rays/update_ray_block_only
# {x, y, z}: predicted displacement, relative to the caster's beam origin.
# Used only when no eligible player can intersect the beam.

tag @s add sgp.ray_refreshed
$teleport @s ~$(x) ~$(y) ~$(z) ~ 0

scoreboard players set #ray_dist sgp.dummy 16000

# The block-specific callback records the first blocking surface and avoids entity collision setup entirely.
function #bs.raycast:run {with:{max_distance:16, ignored_blocks:"#bs.hitbox:can_pass_through", on_targeted_block:"scoreboard players operation #ray_dist sgp.dummy = $raycast.entry_distance bs.lambda"}}

execute unless score @s sgp.dummy = #ray_dist sgp.dummy \
    store result entity @s transformation.scale[2] float 0.002 \
    store result entity @s transformation.translation[2] float 0.0005 \
        run scoreboard players operation @s sgp.dummy = #ray_dist sgp.dummy

# Animate a rotation around its horizontal axis
execute store result entity @s transformation.left_rotation[3] float 0.01 run scoreboard players remove @s sgp.timer 2
