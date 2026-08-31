#> sgp.majeurs:pco/cage/compute_markers_coordinates
#
# Compute the integer clone bounds for the current structure marker.

execute store result entity @s data.x int 1 run data get entity @s Pos[0]
execute store result entity @s data.y int 1 run data get entity @s Pos[1]
execute store result entity @s data.z int 1 run data get entity @s Pos[2]

execute store result score #pco_pos_x sgp.dummy run data get entity @s data.x
execute store result score #pco_pos_y sgp.dummy run data get entity @s data.y
execute store result score #pco_pos_z sgp.dummy run data get entity @s data.z
execute store result score #pco_end_x sgp.dummy run data get entity @s data.dx
execute store result score #pco_end_y sgp.dummy run data get entity @s data.dy
execute store result score #pco_end_z sgp.dummy run data get entity @s data.dz

scoreboard players operation #pco_end_x sgp.dummy += #pco_pos_x sgp.dummy
scoreboard players operation #pco_end_y sgp.dummy += #pco_pos_y sgp.dummy
scoreboard players operation #pco_end_z sgp.dummy += #pco_pos_z sgp.dummy
execute store result entity @s data.x2 int 1 run scoreboard players get #pco_end_x sgp.dummy
execute store result entity @s data.y2 int 1 run scoreboard players get #pco_end_y sgp.dummy
execute store result entity @s data.z2 int 1 run scoreboard players get #pco_end_z sgp.dummy
