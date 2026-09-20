#> sgp.kits:abilities/rays/cache_target_hitboxes
#
# Cache newly relevant vanilla player hitboxes for reuse by all Rays casts this server tick.

execute as @a[tag=sgp.ray_target,tag=!sgp.ray_hitbox_cached,tag=!bs.hitbox.custom,tag=!bs.hitbox.baked,tag=!bs.hitbox.centered] \
    unless score @s bs.width matches -2147483648..2147483647 \
    unless score @s bs.height matches -2147483648..2147483647 \
    unless score @s bs.depth matches -2147483648..2147483647 \
        run function sgp.kits:abilities/rays/cache_target_hitbox

scoreboard players set #ray_hitbox_cache sgp.dummy 1

scoreboard players set #ray_fast_entity sgp.dummy 0
execute unless entity @a[tag=sgp.ray_target,tag=!sgp.ray_hitbox_cached,limit=1] run scoreboard players set #ray_fast_entity sgp.dummy 1
