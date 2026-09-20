#> sgp.kits:abilities/rays/update_ray_fast
# {x, y, z}: predicted displacement, relative to the caster's beam origin.
# Used when every target has a transient vanilla-player hitbox cache.

tag @s add sgp.ray_refreshed
$teleport @s ~$(x) ~$(y) ~$(z) ~ 0

scoreboard players set #ray_dist sgp.dummy 16000

# Preserve the Bookshelf 4.0.1 stale-ID workaround before every entity-enabled cast.
scoreboard players reset @a[tag=sgp.ray_target] bs.raycast.id
function sgp.kits:abilities/rays/raycast_fast/run

execute unless score @s sgp.dummy = #ray_dist sgp.dummy \
    store result entity @s transformation.scale[2] float 0.002 \
    store result entity @s transformation.translation[2] float 0.0005 \
        run scoreboard players operation @s sgp.dummy = #ray_dist sgp.dummy

data modify entity @s transformation.left_rotation[3] set from storage sgp:rays prediction.rotation
