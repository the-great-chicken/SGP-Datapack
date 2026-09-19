#> sgp.kits:abilities/rays/tick

execute if score @s sgp.duration_ability matches 1 run return run function sgp.kits:abilities/rays/end

tag @s add sgp.radiator

# Predict visual movement without moving the collision origin.
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

# Match the existing two-tick horizontal and one-tick vertical prediction.
scoreboard players operation @s sgp.dx *= 2 sgp.dummy
scoreboard players operation @s sgp.dz *= 2 sgp.dummy

execute store result storage sgp:rays prediction.x double 0.001 run scoreboard players get @s sgp.dx
execute store result storage sgp:rays prediction.y double 0.001 run scoreboard players get @s sgp.dy
execute store result storage sgp:rays prediction.z double 0.001 run scoreboard players get @s sgp.dz

# Only players participate in entity collision checks; the caster is excluded.
tag @a[tag=!sgp.radiator] add sgp.ray_target

# Don't directly use `#bs.link:as_children`, as the @e is too expensive without the type
scoreboard players operation $link.to bs.in = @s bs.id
execute as @e[distance=..10,tag=sgp.ray,predicate=bs.link:link_equal,limit=8,type=item_display] run function sgp.kits:abilities/rays/tick_children

tag @a[tag=sgp.ray_target] remove sgp.ray_target

playsound entity.ender_eye.death master @a ~ ~ ~ 1 0

tag @s remove sgp.radiator
