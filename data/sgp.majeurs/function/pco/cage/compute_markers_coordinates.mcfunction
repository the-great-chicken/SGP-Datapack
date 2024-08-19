#> sgp.majeurs:pco/cage/compute_markers_coordinates
#
# Put the position of the markers in their data, and other values,
# to use them later without having to manually specify them

# Store their coords in their data.<x|y|z>
execute store result entity @s data.x int 1 \
    run data get entity @s Pos[0]

execute store result entity @s data.y int 1 \
    run data get entity @s Pos[1]

execute store result entity @s data.z int 1 \
    run data get entity @s Pos[2]


# Store their coords in a score sgp.pos<x|y|z> (to do operations on it)
execute store result score @s sgp.posx \
    run data get entity @s data.x

execute store result score @s sgp.posy \
    run data get entity @s data.y

execute store result score @s sgp.posz \
    run data get entity @s data.z


# Store their data.d<x|y|z> in sgp.pos<x|y|z>1
execute store result score @s sgp.posx1 \
    run data get entity @s data.dx

execute store result score @s sgp.posy1 \
    run data get entity @s data.dy

execute store result score @s sgp.posz1 \
    run data get entity @s data.dz


# Add their coordinates with their difference (d<x|y|z>) 
# to get the ending position and store it in data.<x|y|z>2
execute store result entity @s data.x2 int 1 \
    run scoreboard players operation @s sgp.posx1 += @s sgp.posx

execute store result entity @s data.y2 int 1 \
    run scoreboard players operation @s sgp.posy1 += @s sgp.posy

execute store result entity @s data.z2 int 1 \
    run scoreboard players operation @s sgp.posz1 += @s sgp.posz


# Calculate $(dx)-1
execute store result score #number_to_decrement sgp.dummy \
    run data get entity @s data.dx

execute store result entity @s data.dx1 int 1 \
    run scoreboard players operation #number_to_decrement sgp.dummy -= 1 sgp.dummy


# Calculate $(dz)-1
execute store result score #number_to_decrement sgp.dummy \
    run data get entity @s data.dz

execute store result entity @s data.dz1 int 1 \
    run scoreboard players operation #number_to_decrement sgp.dummy -= 1 sgp.dummy