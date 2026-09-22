#> sgp.diorama:tick/update_mannequin/read_pos_and_rot
#
# Executed as and at a mannequin owner: the player's position and rotation into bs.pos.* and
# bs.rot.* (x1000), the same values as #bs.position:get_pos_and_rot {scale:1000}. One round
# trip of Bookshelf's shuttle marker replaces a marker summon + kill for the position and two
# shuttle trips for the rotation; the player's own NBT is never read (~40 us per read). This
# runs once per in-game player per tick while the Diorama is active.
tp B5-0-0-0-1 ~ ~ ~ ~ ~
execute store result score @s bs.pos.x run data get entity B5-0-0-0-1 Pos[0] 1000
execute store result score @s bs.pos.y run data get entity B5-0-0-0-1 Pos[1] 1000
execute store result score @s bs.pos.z run data get entity B5-0-0-0-1 Pos[2] 1000
execute store result score @s bs.rot.h run data get entity B5-0-0-0-1 Rotation[0] 1000
execute store result score @s bs.rot.v run data get entity B5-0-0-0-1 Rotation[1] 1000
execute in minecraft:overworld run tp B5-0-0-0-1 -30000000 0 1600 0 0
