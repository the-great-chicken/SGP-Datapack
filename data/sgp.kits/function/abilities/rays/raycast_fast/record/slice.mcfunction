#> sgp.kits:abilities/rays/raycast_fast/record/slice

data modify storage bs:ctx _.r prepend from storage bs:data raycast.re[-1]
data remove storage bs:data raycast.re[-1]
execute store result score #u bs.ctx run data get storage bs:data raycast.re[-1].tmin
execute if data storage bs:data raycast.re[-1] \
    if score #x bs.ctx > #u bs.ctx \
        run function sgp.kits:abilities/rays/raycast_fast/record/slice
