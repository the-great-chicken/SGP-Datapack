$data modify entity @s data.fill.block set value "$(block)"
$data modify entity @s data.fill.block_to_replace set value "$(block_to_replace)"

# Calculate $(dx)+1
execute store result score #number_to_increment sgp.dummy run data get entity @s data.fill.dx
execute store result entity @s data.fill.dx1 int 1 run scoreboard players operation #number_to_increment sgp.dummy += 1 sgp.dummy

# Calculate $(dz)+1
execute store result score #number_to_increment sgp.dummy run data get entity @s data.fill.dz
execute store result entity @s data.fill.dz1 int 1 run scoreboard players operation #number_to_increment sgp.dummy += 1 sgp.dummy


$execute store result score #success_outline sgp.dummy at @e[type=marker,tag=sgp.marker,name="pco_$(cage)_cage_arena",limit=1] run function sgp.majeurs:pco/cabane/outline with entity @s data.fill
$execute if score #success_outline sgp.dummy matches 0 at @e[type=marker,tag=sgp.marker,name="pco_$(cage)_cage_arena",limit=1] run function sgp.majeurs:pco/cabane/outline_no_orientation with entity @s data.fill