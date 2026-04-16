#> sgp.kits:abilities/rays/tick

execute if score @s sgp.duration_ability matches 1 run return run function sgp.kits:abilities/rays/end

tag @s add sgp.radiator

# Extrapolation system to be able to smooth the rays movement with teleport-duration
# While having them not lag behind too much
function #bs.position:get_pos {scale:1000}

# 2. Calculate the Delta (Velocity)
scoreboard players operation @s sgp.dx = @s bs.pos.x
scoreboard players operation @s sgp.dx -= @s sgp.old_x
scoreboard players operation @s sgp.dy = @s bs.pos.y
scoreboard players operation @s sgp.dy -= @s sgp.old_y
scoreboard players operation @s sgp.dz = @s bs.pos.z
scoreboard players operation @s sgp.dz -= @s sgp.old_z

# 3. Save Current as Old for the next tick
scoreboard players operation @s sgp.old_x = @s bs.pos.x
scoreboard players operation @s sgp.old_y = @s bs.pos.y
scoreboard players operation @s sgp.old_z = @s bs.pos.z

# 4. Predict the Future (Multiply Delta by teleport_duration, e.g., 3)
scoreboard players operation @s sgp.dx *= 2 sgp.dummy
scoreboard players operation @s sgp.dy *= 1 sgp.dummy
scoreboard players operation @s sgp.dz *= 2 sgp.dummy

# 5. Move the Predictor Marker
# First, snap the marker exactly to the player's current true position
tp @e[tag=sgp.predictor,limit=1,type=marker] @s

# Pass the extrapolated delta to the marker
scoreboard players operation @e[tag=sgp.predictor,limit=1,type=marker] bs.pos.x = @s sgp.dx
scoreboard players operation @e[tag=sgp.predictor,limit=1,type=marker] bs.pos.y = @s sgp.dy
scoreboard players operation @e[tag=sgp.predictor,limit=1,type=marker] bs.pos.z = @s sgp.dz

# Use Bookshelf to offset the marker by those delta scores
execute as @e[tag=sgp.predictor,limit=1,type=marker] run function #bs.position:add_pos {scale:0.001}

function #bs.link:as_children {run:"function sgp.kits:abilities/rays/tick_children"}

playsound entity.ender_eye.death master @a ~ ~ ~ 1 0

tag @s remove sgp.radiator