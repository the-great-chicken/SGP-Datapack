#> sgp.kits:abilities/rays/cache_target_hitbox
#
# Cache Bookshelf's resolved hitbox dimensions in its score-backed fast path.

function #bs.hitbox:get_entity
execute store result score #ray_hitbox_w sgp.dummy run data get storage bs:out hitbox.width 5000
execute store result score #ray_hitbox_h sgp.dummy run data get storage bs:out hitbox.height 5000
execute store result score #ray_hitbox_d sgp.dummy run data get storage bs:out hitbox.depth 5000
execute store result score #ray_hitbox_s sgp.dummy run data get storage bs:out hitbox.scale 1000
scoreboard players operation #ray_hitbox_w sgp.dummy *= #ray_hitbox_s sgp.dummy
scoreboard players operation #ray_hitbox_h sgp.dummy *= #ray_hitbox_s sgp.dummy
scoreboard players operation #ray_hitbox_d sgp.dummy *= #ray_hitbox_s sgp.dummy

scoreboard players operation @s bs.width = #ray_hitbox_w sgp.dummy
scoreboard players operation @s bs.height = #ray_hitbox_h sgp.dummy
scoreboard players operation @s bs.depth = #ray_hitbox_d sgp.dummy
tag @s add sgp.ray_hitbox_cached
