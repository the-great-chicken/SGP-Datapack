#> sgp.kits:abilities/rays/raycast_fast/run
#
# Rays-specialized block + entity cast for cached vanilla player hitboxes.
# Bookshelf retains exact block collision; entity records keep only the ordering data Rays consumes.

data modify storage bs:data raycast set value {sx:1,sy:1,sz:1,blocks:"function #bs.hitbox:callback/get_block_shape",entities:"sgp.ray_target,level=0..",max_distance:16.0,ignored_blocks:"#bs.hitbox:can_pass_through",ignored_entities:"#bs.hitbox:intangible",piercing:{entities:50},on_targeted_block:"scoreboard players operation #ray_dist sgp.dummy = $raycast.entry_distance bs.lambda"}

scoreboard players set #ray_fast_blocks sgp.dummy 1
scoreboard players set #raycast.dm bs.data 16000
scoreboard players set #raycast.pb bs.data 1
scoreboard players set #raycast.pe bs.data 51

execute store result score #raycast.tb bs.data store result score #raycast.te bs.data \
    run scoreboard players set #raycast.tm bs.data 2147483647
scoreboard players set #count bs.raycast.id 0

tag @e[tag=bs.raycast.checked,distance=..255] remove bs.raycast.checked
execute positioned ^ ^ ^ summon minecraft:marker \
    run function sgp.kits:abilities/rays/raycast_fast/recurse/init with storage bs:data raycast
