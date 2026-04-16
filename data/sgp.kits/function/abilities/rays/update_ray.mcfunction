#> sgp.kits:abilities/rays/update_ray
# `{direction: north|south|east|west|north_east|..., rotation: int}`
#
# Update the ray size, and rotation animation

$execute positioned as @e[tag=sgp.predictor,limit=1,type=marker] run teleport @s ~ ~0.6 ~ $(rotation) 0

scoreboard players set #ray_dist sgp.dummy 16000

$execute positioned ~ ~0.6 ~ rotated $(rotation) 0 run function #bs.raycast:run {with:{max_distance:16, ignored_blocks:"#bs.hitbox:can_pass_through", entities:"!sgp.radiator", on_hit_point:"execute unless score $raycast.hit_flag bs.lambda matches -1 run scoreboard players operation #ray_dist sgp.dummy = $raycast.distance bs.lambda", piercing: {entities: 50}, on_targeted_entity:"execute if entity @s[tag=!sgp.peaceful] at @s run function sgp.kits:abilities/rays/get_damaged"}}

# Update scale (0.002 fixes the 0.5 base size) Bookshelf returns $raycast.entry_distance as (distance * 1000) inside its callback.
execute store result entity @s transformation.scale[2] float 0.002 run scoreboard players get #ray_dist sgp.dummy

# Update translation (0.0005 pushes the center forward by exactly half its length)
execute store result entity @s transformation.translation[2] float 0.0005 run scoreboard players get #ray_dist sgp.dummy

# Animate a rotation around its horizontal axis
scoreboard players remove @s sgp.timer 2
execute store result entity @s transformation.left_rotation[3] float 0.01 run scoreboard players get @s sgp.timer