#> sgp.kits:abilities/tnt/apply_kb

# Calculate a forward direction vector based on the player's rotation. The scale represents the knockback strength.
function #bs.position:get_relative_from_dir {scale: 700}

# Add a slight upward trajectory to the Y-axis.
scoreboard players add @s bs.pos.y 600

scoreboard players operation @s bs.vel.x = @s bs.pos.x
scoreboard players operation @s bs.vel.y = @s bs.pos.y
scoreboard players operation @s bs.vel.z = @s bs.pos.z

function #bs.move:set_motion {scale: 0.001}