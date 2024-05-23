# Coords 2 ticks before
execute as @a run scoreboard players operation @s sgp.posx1 = @s sgp.posx
execute as @a run scoreboard players operation @s sgp.posy1 = @s sgp.posy
execute as @a run scoreboard players operation @s sgp.posz1 = @s sgp.posz

# Current coords
execute as @a store result score @s sgp.posx run data get entity @s Pos[0] 100
execute as @a store result score @s sgp.posy run data get entity @s Pos[1] 100
execute as @a store result score @s sgp.posz run data get entity @s Pos[2] 100