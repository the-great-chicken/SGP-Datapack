#> sgp.kits:abilities/rays/tick_children

tag @s add sgp.ray_refreshed
# Keep the caster's position and use the display's fixed direction.
execute positioned ~ ~0.6 ~ rotated as @s run function sgp.kits:abilities/rays/update_ray with storage sgp:rays prediction
