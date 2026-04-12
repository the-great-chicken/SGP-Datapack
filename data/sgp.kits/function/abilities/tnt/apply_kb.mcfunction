#> sgp.kits:abilities/tnt/apply_kb

# Calculate a forward direction vector based on the player's rotation. The scale represents the knockback strength.
execute rotated as @s as @n[type=tnt] run function #bs.position:get_relative_from_dir {scale: 700}

# Add a slight upward trajectory to the Y-axis.
execute as @n[type=tnt] run scoreboard players add @s bs.pos.y 600

execute as @n[type=tnt] run scoreboard players operation @s bs.vel.x = @s bs.pos.x
execute as @n[type=tnt] run scoreboard players operation @s bs.vel.y = @s bs.pos.y
execute as @n[type=tnt] run scoreboard players operation @s bs.vel.z = @s bs.pos.z

execute as @n[type=tnt] run function #bs.move:set_motion {scale: 0.001}