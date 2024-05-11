# Coords 2 ticks before
execute as @a run scoreboard players operation @s posx1 = @s posx
execute as @a run scoreboard players operation @s posy1 = @s posy
execute as @a run scoreboard players operation @s posz1 = @s posz

# Current coords
execute as @a store result score @s posx run data get entity @s Pos[0] 100
execute as @a store result score @s posy run data get entity @s Pos[1] 100
execute as @a store result score @s posz run data get entity @s Pos[2] 100