#> sgp.kits:abilities/illusions/apply_left

# Teleport the mannequin to our current execution position (the center marker)
tp @s ~ ~ ~ ~90 ~

# Safely read the player's offset from the marker we are standing inside
scoreboard players operation $px bs.in = @e[type=marker,tag=sgp.illusion_center,distance=..0.1,limit=1] bs.pos.x
scoreboard players operation $py bs.in = @e[type=marker,tag=sgp.illusion_center,distance=..0.1,limit=1] bs.pos.y
scoreboard players operation $pz bs.in = @e[type=marker,tag=sgp.illusion_center,distance=..0.1,limit=1] bs.pos.z

# Swap the axes for the LEFT mannequin (X = Z, Z = -X)
scoreboard players operation @s bs.pos.x = $pz bs.in

scoreboard players set @s bs.pos.z 0
scoreboard players operation @s bs.pos.z -= $px bs.in

# Copy Y normally (but it's actually a negative number so we're inverting)
scoreboard players set @s bs.pos.y 0
scoreboard players operation @s bs.pos.y -= $py bs.in

# Add the swapped offset to push the mannequin into formation
function #bs.position:add_pos {scale:0.001}