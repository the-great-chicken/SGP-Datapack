#> sgp.kits:abilities/rays/clear_target_hitboxes
#
# Remove transient Bookshelf hitbox scores after all duration abilities have ticked.

scoreboard players reset @a[tag=sgp.ray_hitbox_cached] bs.width
scoreboard players reset @a[tag=sgp.ray_hitbox_cached] bs.height
scoreboard players reset @a[tag=sgp.ray_hitbox_cached] bs.depth
tag @a[tag=sgp.ray_hitbox_cached] remove sgp.ray_hitbox_cached
