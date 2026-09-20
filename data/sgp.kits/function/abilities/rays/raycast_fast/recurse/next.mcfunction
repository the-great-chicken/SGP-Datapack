#> sgp.kits:abilities/rays/raycast_fast/recurse/next
#
# Check the current voxel using Bookshelf's block path and the reduced Rays entity path.

execute unless block ~ ~ ~ #bs.hitbox:can_pass_through \
    run function bs.raycast:check/block/any with storage bs:data raycast
execute if score #raycast.dm bs.data matches 1.. \
    as @e[type=!#bs.hitbox:intangible,tag=sgp.ray_target,level=0..,tag=!bs.raycast.checked,dx=0,sort=nearest] \
        run function sgp.kits:abilities/rays/raycast_fast/check/entity
execute if score #raycast.dm bs.data matches 1.. \
    if score #raycast.tm bs.data <= #raycast.lx bs.data \
    if score #raycast.tm bs.data <= #raycast.ly bs.data \
    if score #raycast.tm bs.data <= #raycast.lz bs.data \
        run function sgp.kits:abilities/rays/raycast_fast/react/any

execute if score #raycast.lx bs.data <= #raycast.ly bs.data \
    if score #raycast.lx bs.data <= #raycast.lz bs.data \
    if score #raycast.lx bs.data <= #raycast.dm bs.data \
        run return run function sgp.kits:abilities/rays/raycast_fast/recurse/x with storage bs:data raycast
execute if score #raycast.ly bs.data <= #raycast.lz bs.data \
    if score #raycast.ly bs.data <= #raycast.dm bs.data \
        run return run function sgp.kits:abilities/rays/raycast_fast/recurse/y with storage bs:data raycast
execute if score #raycast.lz bs.data <= #raycast.dm bs.data \
    run return run function sgp.kits:abilities/rays/raycast_fast/recurse/z with storage bs:data raycast
