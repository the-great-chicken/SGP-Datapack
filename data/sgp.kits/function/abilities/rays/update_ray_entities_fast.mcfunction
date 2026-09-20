#> sgp.kits:abilities/rays/update_ray_entities_fast
# {x, y, z}: predicted displacement, relative to the caster's beam origin.
# Used for cached-target cardinal beams already proven clear of blocking blocks.

tag @s add sgp.ray_refreshed
$teleport @s ~$(x) ~$(y) ~$(z) ~ 0

# Preserve the Bookshelf 4.0.1 stale-ID workaround before every entity-enabled cast.
scoreboard players reset @a[tag=sgp.ray_target] bs.raycast.id
function sgp.kits:abilities/rays/raycast_fast/run_entities

execute unless score @s sgp.dummy matches 16000 \
    store result entity @s transformation.scale[2] float 0.002 \
    store result entity @s transformation.translation[2] float 0.0005 \
        run scoreboard players set @s sgp.dummy 16000

data modify entity @s transformation.left_rotation[3] set from storage sgp:rays prediction.rotation
