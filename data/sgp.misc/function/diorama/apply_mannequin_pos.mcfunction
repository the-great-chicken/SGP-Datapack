#> sgp.misc:diorama/apply_mannequin_pos

# Pull the calculated coordinates and rotation from the temporary global storage
scoreboard players operation @s bs.pos.x = $temp_x sgp.dummy
scoreboard players operation @s bs.pos.y = $temp_y sgp.dummy
scoreboard players operation @s bs.pos.z = $temp_z sgp.dummy
scoreboard players operation @s bs.rot.h = $temp_h sgp.dummy
scoreboard players operation @s bs.rot.v = $temp_v sgp.dummy

function #bs.position:set_pos_and_rot {scale:0.001}

# Reset the mannequins' timeout, bypassing bs' API for performance
scoreboard players set @s bs.ttl 100

execute if score $pose sgp.dummy matches 1 run return run data modify entity @s pose set value "crouching"
execute if score $pose sgp.dummy matches 2 run return run data modify entity @s pose set value "swimming"
execute if score $pose sgp.dummy matches 3 run return run data modify entity @s pose set value "fall_flying"
execute if score $pose sgp.dummy matches 0 run return run data modify entity @s pose set value "standing"