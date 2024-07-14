execute as @s store result entity @s data.x int 1 run data get entity @s Pos[0]
execute as @s store result entity @s data.y int 1 run data get entity @s Pos[1]
execute as @s store result entity @s data.z int 1 run data get entity @s Pos[2]

execute as @s store result score @s sgp.posx run data get entity @s data.x
execute as @s store result score @s sgp.posy run data get entity @s data.y
execute as @s store result score @s sgp.posz run data get entity @s data.z

execute as @s store result score @s sgp.posx1 run data get entity @s data.dx
execute as @s store result score @s sgp.posy1 run data get entity @s data.dy
execute as @s store result score @s sgp.posz1 run data get entity @s data.dz

execute as @s store result entity @s data.x2 int 1 run scoreboard players operation @s sgp.posx1 += @s sgp.posx
execute as @s store result entity @s data.y2 int 1 run scoreboard players operation @s sgp.posy1 += @s sgp.posy
execute as @s store result entity @s data.z2 int 1 run scoreboard players operation @s sgp.posz1 += @s sgp.posz

# Calculate $(dx)-1
execute store result score #number_to_decrement sgp.dummy run data get entity @s data.dx
execute store result entity @s data.dx1 int 1 run scoreboard players operation #number_to_decrement sgp.dummy -= 1 sgp.dummy

# Calculate $(dz)-1
execute store result score #number_to_decrement sgp.dummy run data get entity @s data.dz
execute store result entity @s data.dz1 int 1 run scoreboard players operation #number_to_decrement sgp.dummy -= 1 sgp.dummy