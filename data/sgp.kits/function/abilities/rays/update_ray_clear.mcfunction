#> sgp.kits:abilities/rays/update_ray_clear
# {x, y, z}: predicted displacement, relative to the caster's beam origin.
# Used after a cardinal voxel scan proves the full 16-block beam is unobstructed.

tag @s add sgp.ray_refreshed
$teleport @s ~$(x) ~$(y) ~$(z) ~ 0

execute unless score @s sgp.dummy matches 16000 \
    store result entity @s transformation.scale[2] float 0.002 \
    store result entity @s transformation.translation[2] float 0.0005 \
        run scoreboard players set @s sgp.dummy 16000

# Animate a rotation around its horizontal axis
data modify entity @s transformation.left_rotation[3] set from storage sgp:rays prediction.rotation
