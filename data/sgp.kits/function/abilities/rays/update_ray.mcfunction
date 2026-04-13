#> sgp.kits:abilities/rays/update_ray
#
# `{direction: north|south|east|west|north_east|..., rotation: int}`
# Update the ray size, and rotation animation

$execute positioned ~ ~0.6 ~ run teleport @n[type=item_display,tag=sgp.ray,tag=sgp.$(direction)] ~ ~ ~ $(rotation) 0

$scoreboard players set #ray_dist_$(direction) sgp.dummy 12000

$execute positioned ~ ~0.6 ~ rotated $(rotation) 0 run function #bs.raycast:run {with:{max_distance:12, entities:"!sgp.radiator", on_hit_point:"execute unless score $raycast.hit_flag bs.lambda matches -1 run scoreboard players operation #ray_dist_$(direction) sgp.dummy = $raycast.distance bs.lambda", piercing: {entities: 50}, on_targeted_entity:"execute if entity @s[tag=!sgp.peaceful] run function sgp.kits:abilities/rays/get_damaged"}}

# Update scale (0.002 fixes the 0.5 base size) Bookshelf returns $raycast.entry_distance as (distance * 1000) inside its callback.
$execute store result entity @s transformation.scale[2] float 0.002 run scoreboard players get #ray_dist_$(direction) sgp.dummy

# Update translation (0.0005 pushes the center forward by exactly half its length)
$execute store result entity @s transformation.translation[2] float 0.0005 run scoreboard players get #ray_dist_$(direction) sgp.dummy

# Animate a rotation around its horizontal axis
scoreboard players remove @s sgp.timer 2
execute store result entity @s transformation.left_rotation[3] float 0.01 run scoreboard players get @s sgp.timer
data modify entity @s start_interpolation set value 0