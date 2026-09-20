#> sgp.kits:abilities/rays/raycast_fast/react/entity
#
# Apply the Rays callback and advance to the next ordered entity record.

execute if score #raycast.pe bs.data matches 0.. run scoreboard players remove #raycast.pe bs.data 1
scoreboard players operation $raycast.piercing bs.lambda = #raycast.pe bs.data

execute at @s run function sgp.kits:abilities/rays/get_damaged

scoreboard players operation #raycast.pe bs.data = $raycast.piercing bs.lambda

data remove storage bs:data raycast.re[-1]
execute unless data storage bs:data raycast.re[-1] \
    run return run scoreboard players set #raycast.te bs.data 2147483647
execute store result score #raycast.te bs.data run data get storage bs:data raycast.re[-1].tmin
execute store result score #raycast.id bs.data run data get storage bs:data raycast.re[-1].id
