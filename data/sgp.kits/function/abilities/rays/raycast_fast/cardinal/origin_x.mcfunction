#> sgp.kits:abilities/rays/raycast_fast/cardinal/origin_x

$execute positioned ~$(x) ~$(y) ~$(z) run tp @s ~ ~ ~
execute store result score #raycast.rx bs.data run data get entity @s Pos[0] -10000000
tp @s -30000000 0 1600
