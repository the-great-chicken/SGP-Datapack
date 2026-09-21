#> sgp.diorama:tick/update_mannequin/apply_mannequin_pos

# Pull the calculated coordinates and rotation from the temporary global storage
scoreboard players operation @s bs.pos.x = $temp_x sgp.dummy
scoreboard players operation @s bs.pos.y = $temp_y sgp.dummy
scoreboard players operation @s bs.pos.z = $temp_z sgp.dummy
scoreboard players operation @s bs.rot.h = $temp_h sgp.dummy
scoreboard players operation @s bs.rot.v = $temp_v sgp.dummy

execute store result storage sgp:diorama tp.x double 0.001 run scoreboard players get @s bs.pos.x
execute store result storage sgp:diorama tp.y double 0.001 run scoreboard players get @s bs.pos.y
execute store result storage sgp:diorama tp.z double 0.001 run scoreboard players get @s bs.pos.z
execute store result storage sgp:diorama tp.h double 0.001 run scoreboard players get @s bs.rot.h
execute store result storage sgp:diorama tp.v double 0.001 run scoreboard players get @s bs.rot.v
function sgp.diorama:tick/update_mannequin/teleport with storage sgp:diorama tp

# Reset the mannequins' timeout, bypassing bs' API for performance
scoreboard players set @s bs.ttl 100

execute if score @s sgp.last_pose = $pose sgp.dummy run return 0
scoreboard players operation @s sgp.last_pose = $pose sgp.dummy

execute if score $pose sgp.dummy matches 1 run return run data modify entity @s pose set value "crouching"
execute if score $pose sgp.dummy matches 2 run return run data modify entity @s pose set value "swimming"
execute if score $pose sgp.dummy matches 3 run return run data modify entity @s pose set value "fall_flying"
execute if score $pose sgp.dummy matches 0 run return run data modify entity @s pose set value "standing"