#> sgp.majeurs:pco/cabane/change_cabane_block
# `{block, block_to_replace, block_2, block_to_replace_2, cage}`
# 
# This function is able to replace the blocks of a cabane

# ---------- OUTLINE ----------
$data modify entity @s data.fill.block set value "$(block)"
$data modify entity @s data.fill.block_to_replace set value "$(block_to_replace)"


# Calculate $(dx)+1
execute store result score #number_to_increment sgp.dummy \
    run data get entity @s data.fill.dx

execute store result entity @s data.fill.dx1 int 1 \
    run scoreboard players operation #number_to_increment sgp.dummy += 1 sgp.dummy

# Calculate $(dz)+1
execute store result score #number_to_increment sgp.dummy \
    run data get entity @s data.fill.dz

execute store result entity @s data.fill.dz1 int 1 \
    run scoreboard players operation #number_to_increment sgp.dummy += 1 sgp.dummy


$execute store result score #success_outline sgp.dummy \
    at @e[type=marker,tag=sgp.marker,name="pco_$(cage)_cage_arena",limit=1] \
        run function sgp.majeurs:pco/cabane/outline with entity @s data.fill

# If it didn't work, that means there shouldn't be a direction applied to the block
$execute if score #success_outline sgp.dummy matches 0 \
    at @e[type=marker,tag=sgp.marker,name="pco_$(cage)_cage_arena",limit=1] \
        run function sgp.majeurs:pco/cabane/outline_no_orientation with entity @s data.fill


# ---------- GROUND ----------
$data modify entity @s data.fill.block_2 set value "$(block_2)"
$data modify entity @s data.fill.block_to_replace_2 set value "$(block_to_replace_2)"


$execute at @e[type=marker,tag=sgp.marker,name="pco_$(cage)_cage_arena",limit=1] \
    run function sgp.majeurs:pco/cabane/ground with entity @s data.fill