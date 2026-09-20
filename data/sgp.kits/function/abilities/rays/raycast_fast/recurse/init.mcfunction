#> sgp.kits:abilities/rays/raycast_fast/recurse/init
#
# Initialize Bookshelf-compatible DDA state, then enter the Rays-specialized collision loop.

data modify storage bs:ctx _ set from entity @s Pos
execute store result score #raycast.x bs.data store result storage bs:data raycast.x int -1 run data get storage bs:ctx _[0]
execute store result score #raycast.y bs.data store result storage bs:data raycast.y int -1 run data get storage bs:ctx _[1]
execute store result score #raycast.z bs.data store result storage bs:data raycast.z int -1 run data get storage bs:ctx _[2]

execute positioned 0.0 0.0 0.0 run tp @s ^ ^ ^10
data modify storage bs:ctx _ set from entity @s Pos
execute store result score #raycast.ux bs.data run data get storage bs:ctx _[0] 1000
execute store result score #raycast.uy bs.data run data get storage bs:ctx _[1] 1000
execute store result score #raycast.uz bs.data run data get storage bs:ctx _[2] 1000

execute store result score #raycast.dx bs.data store result score #raycast.dy bs.data run scoreboard players set #raycast.dz bs.data 10000000
execute if score #raycast.ux bs.data matches ..-1 store result storage bs:data raycast.sx int .0000001 run scoreboard players set #raycast.dx bs.data -10000000
execute if score #raycast.uy bs.data matches ..-1 store result storage bs:data raycast.sy int .0000001 run scoreboard players set #raycast.dy bs.data -10000000
execute if score #raycast.uz bs.data matches ..-1 store result storage bs:data raycast.sz int .0000001 run scoreboard players set #raycast.dz bs.data -10000000
scoreboard players operation #raycast.dx bs.data /= #raycast.ux bs.data
scoreboard players operation #raycast.dy bs.data /= #raycast.uy bs.data
scoreboard players operation #raycast.dz bs.data /= #raycast.uz bs.data

function bs.raycast:utils/get_relative_pos with storage bs:data raycast
execute store result score #raycast.rx bs.data store result score #raycast.lx bs.data run data get storage bs:ctx _[0] -10000000
execute store result score #raycast.ry bs.data store result score #raycast.ly bs.data run data get storage bs:ctx _[1] -10000000
execute store result score #raycast.rz bs.data store result score #raycast.lz bs.data run data get storage bs:ctx _[2] -10000000
execute if score #raycast.ux bs.data matches 0.. run scoreboard players add #raycast.lx bs.data 10000000
execute if score #raycast.uy bs.data matches 0.. run scoreboard players add #raycast.ly bs.data 10000000
execute if score #raycast.uz bs.data matches 0.. run scoreboard players add #raycast.lz bs.data 10000000
scoreboard players operation #raycast.lx bs.data /= #raycast.ux bs.data
scoreboard players operation #raycast.ly bs.data /= #raycast.uy bs.data
scoreboard players operation #raycast.lz bs.data /= #raycast.uz bs.data

execute if score #ray_fast_blocks sgp.dummy matches 0 \
    align xyz run function sgp.kits:abilities/rays/raycast_fast/recurse/entities/next with storage bs:data raycast
execute if score #ray_fast_blocks sgp.dummy matches 1 \
    align xyz run function sgp.kits:abilities/rays/raycast_fast/recurse/next with storage bs:data raycast
tp @s ~ -100000 ~
kill @s
