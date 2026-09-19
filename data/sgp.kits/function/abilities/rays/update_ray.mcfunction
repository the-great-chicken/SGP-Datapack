#> sgp.kits:abilities/rays/update_ray
# {x, y, z}: predicted displacement, relative to the caster's beam origin.

tag @s add sgp.ray_refreshed
$teleport @s ~$(x) ~$(y) ~$(z) ~ 0

scoreboard players set #ray_dist sgp.dummy 16000

# Bookshelf 4.0.1 restarts its per-cast ID counter but retains entity IDs, allowing target collisions.
scoreboard players reset @a[tag=sgp.ray_target] bs.raycast.id
# Beam length depends only on the first blocking block. A block-specific callback avoids the generic entry callback on entity hits.
function #bs.raycast:run {with:{max_distance:16, ignored_blocks:"#bs.hitbox:can_pass_through", entities:"sgp.ray_target,level=0..", on_targeted_block:"scoreboard players operation #ray_dist sgp.dummy = $raycast.entry_distance bs.lambda", piercing: {entities: 50}, on_targeted_entity:"function sgp.kits:abilities/rays/get_damaged"}}

execute unless score @s sgp.dummy = #ray_dist sgp.dummy \
    store result entity @s transformation.scale[2] float 0.002 \
    store result entity @s transformation.translation[2] float 0.0005 \
        run scoreboard players operation @s sgp.dummy = #ray_dist sgp.dummy

# Animate a rotation around its horizontal axis
execute store result entity @s transformation.left_rotation[3] float 0.01 run scoreboard players remove @s sgp.timer 2
