#> sgp.kits:abilities/rays/raycast_fast/record/add
#
# Insert one hit in Bookshelf's tmin order, retaining only fields Rays consumes.

data modify storage bs:ctx _ set value {r:[],e:{}}
execute if score #x bs.ctx > #raycast.te bs.data \
    run function sgp.kits:abilities/rays/raycast_fast/record/slice
scoreboard players operation #raycast.te bs.data < #x bs.ctx
scoreboard players operation #raycast.tm bs.data < #raycast.te bs.data

execute unless score @s bs.raycast.id matches 1.. \
    store result score @s bs.raycast.id \
        run scoreboard players add #count bs.raycast.id 1
execute store result storage bs:ctx _.e.id int 1 run scoreboard players get @s bs.raycast.id
execute store result storage bs:ctx _.e.tmin int 1 run scoreboard players get #x bs.ctx

data modify storage bs:data raycast.re append from storage bs:ctx _.e
data modify storage bs:data raycast.re append from storage bs:ctx _.r[]
execute store result score #raycast.id bs.data run data get storage bs:data raycast.re[-1].id
