#> sgp.kits:abilities/rays/clear_target_hitbox
#
# Invalidate one transient Bookshelf hitbox cached by Rays.

scoreboard players reset @s bs.width
scoreboard players reset @s bs.height
scoreboard players reset @s bs.depth
tag @s remove sgp.ray_hitbox_cached
