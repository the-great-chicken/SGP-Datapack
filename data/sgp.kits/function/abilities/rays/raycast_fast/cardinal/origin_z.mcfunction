#> sgp.kits:abilities/rays/raycast_fast/cardinal/origin_z
# {x, z}: negated block coordinates of the collision origin. Executed as the Bookshelf shuttle at the collision origin.

$execute positioned ~$(x) ~ ~$(z) run tp @s ~ ~ ~
execute store result score #raycast.rz bs.data run data get entity @s Pos[2] -10000000
tp @s -30000000 0 1600
