#> sgp.misc:player_mannequins/apply_mannequin_pos

# Pull the calculated coordinates and rotation from the temporary global storage
scoreboard players operation @s bs.pos.x = #temp_x sgp.dummy
scoreboard players operation @s bs.pos.y = #temp_y sgp.dummy
scoreboard players operation @s bs.pos.z = #temp_z sgp.dummy
scoreboard players operation @s bs.rot.h = #temp_h sgp.dummy
scoreboard players operation @s bs.rot.v = #temp_v sgp.dummy

# Set the position and rotation
# We scale by 0.001 to reverse the milliblock/millidegree precision multiplier so the game teleports them perfectly smoothly.
function #bs.position:set_pos {scale:0.001}
function #bs.position:set_rot {scale:0.001}

# Reset the mannequins' timeout
function #bs.health:time_to_live {with:{time:5,unit:"s",on_death:"execute on passengers run kill @s"}}

execute if score #pose sgp.dummy matches 1 run return run data modify entity @s pose set value "crouching"
execute if score #pose sgp.dummy matches 2 run return run data modify entity @s pose set value "swimming"
execute if score #pose sgp.dummy matches 0 run return run data modify entity @s pose set value "standing"