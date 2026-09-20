#> sgp.kits:abilities/rays/raycast_fast/recurse/entities/next
#
# Entity-only DDA loop for a beam already proven clear of blocking blocks.

execute as @e[type=!#bs.hitbox:intangible,tag=sgp.ray_target,level=0..,tag=!bs.raycast.checked,dx=0,sort=nearest] \
    run function sgp.kits:abilities/rays/raycast_fast/check/entity
execute if score #raycast.tm bs.data <= #raycast.lx bs.data \
    if score #raycast.tm bs.data <= #raycast.ly bs.data \
    if score #raycast.tm bs.data <= #raycast.lz bs.data \
        run function sgp.kits:abilities/rays/raycast_fast/react/entities

execute if score #raycast.lx bs.data <= #raycast.ly bs.data \
    if score #raycast.lx bs.data <= #raycast.lz bs.data \
    if score #raycast.lx bs.data <= #raycast.dm bs.data \
        run return run function sgp.kits:abilities/rays/raycast_fast/recurse/entities/x with storage bs:data raycast
execute if score #raycast.ly bs.data <= #raycast.lz bs.data \
    if score #raycast.ly bs.data <= #raycast.dm bs.data \
        run return run function sgp.kits:abilities/rays/raycast_fast/recurse/entities/y with storage bs:data raycast
execute if score #raycast.lz bs.data <= #raycast.dm bs.data \
    run return run function sgp.kits:abilities/rays/raycast_fast/recurse/entities/z with storage bs:data raycast
