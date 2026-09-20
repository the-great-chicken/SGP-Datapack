#> sgp.kits:abilities/rays/update_ray_entities_only
# {x, y, z}: predicted displacement, relative to the caster's beam origin.
# Used after a cardinal voxel scan proves block collision is impossible.

tag @s add sgp.ray_refreshed
$teleport @s ~$(x) ~$(y) ~$(z) ~ 0

# Bookshelf 4.0.1 restarts its per-cast ID counter but retains entity IDs, allowing target collisions.
scoreboard players reset @a[tag=sgp.ray_target] bs.raycast.id
function #bs.raycast:run {with:{blocks:false, max_distance:16, entities:"sgp.ray_target,level=0..", piercing:{entities:50}, on_targeted_entity:"function sgp.kits:abilities/rays/get_damaged"}}

execute unless score @s sgp.dummy matches 16000 \
    store result entity @s transformation.scale[2] float 0.002 \
    store result entity @s transformation.translation[2] float 0.0005 \
        run scoreboard players set @s sgp.dummy 16000

# Animate a rotation around its horizontal axis
execute store result entity @s transformation.left_rotation[3] float 0.01 run scoreboard players remove @s sgp.timer 2
