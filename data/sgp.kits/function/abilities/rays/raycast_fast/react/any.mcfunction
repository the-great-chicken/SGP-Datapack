#> sgp.kits:abilities/rays/raycast_fast/react/any
#
# Preserve Bookshelf block/entity ordering while avoiding unused entity hit outputs.

execute if score #raycast.tm bs.data = #raycast.tb bs.data \
    run function bs.raycast:react/block
execute if score #raycast.tm bs.data = #raycast.te bs.data \
    positioned as @s \
    as @e[tag=bs.raycast.checked,predicate=bs.raycast:internal/id,level=0..,distance=..255,limit=1] \
        run function sgp.kits:abilities/rays/raycast_fast/react/entity

execute if score $raycast.piercing bs.lambda matches 0 \
    run return run scoreboard players set #raycast.dm bs.data -2147483648

scoreboard players set #raycast.tm bs.data 2147483647
scoreboard players operation #raycast.tm bs.data < #raycast.tb bs.data
scoreboard players operation #raycast.tm bs.data < #raycast.te bs.data

execute if score #raycast.tm bs.data <= #raycast.lx bs.data \
    if score #raycast.tm bs.data <= #raycast.ly bs.data \
    if score #raycast.tm bs.data <= #raycast.lz bs.data \
        run function sgp.kits:abilities/rays/raycast_fast/react/any
