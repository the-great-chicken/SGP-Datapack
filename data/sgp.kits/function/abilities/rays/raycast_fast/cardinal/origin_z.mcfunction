#> sgp.kits:abilities/rays/raycast_fast/cardinal/origin_z

$execute positioned ~$(x) ~$(y) ~$(z) run tp @s ~ ~ ~
execute store result score #raycast.rz bs.data run data get entity @s Pos[2] -10000000
tp @s -30000000 0 1600
