#> sgp.kits:abilities/rays/raycast_fast/cardinal/position_x
# {x, z}: negated block coordinates of the collision origin. Executed as the Bookshelf shuttle at the candidate target.

$execute positioned ~$(x) ~ ~$(z) run tp @s ~ ~ ~
execute store result score #x bs.ctx run data get entity @s Pos[0] 10000000
tp @s -30000000 0 1600
