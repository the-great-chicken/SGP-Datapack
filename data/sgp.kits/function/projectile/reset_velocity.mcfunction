#> sgp.kits:projectile/reset_velocity

# Capture the projectile's original speed dynamically
execute store result score $vector.length.0 bs.in run data get entity @s Motion[0] 1000
execute store result score $vector.length.1 bs.in run data get entity @s Motion[1] 1000
execute store result score $vector.length.2 bs.in run data get entity @s Motion[2] 1000

function #bs.vector:length

# Override the speed for fixed-speed projectiles (Scale is 1000x)
execute if entity @s[type=splash_potion] run scoreboard players set $vector.length bs.out 500
execute if entity @s[type=ender_pearl] run scoreboard players set $vector.length bs.out 1500
execute if entity @s[type=snowball] run scoreboard players set $vector.length bs.out 1500
execute if entity @s[type=egg] run scoreboard players set $vector.length bs.out 1500


# Get the clean directional vector from the shooter's aim
execute on origin rotated as @s positioned 0.0 0.0 0.0 run summon marker ^ ^ ^1 {Tags:["sgp.aim_vector"]}

# Store the normalized direction (length = 1) into temporary scores, scaled by 1000
execute store result score #dir_x sgp.dummy run data get entity @e[tag=sgp.aim_vector,limit=1,x=-3,y=-3,z=-3,dx=9,dy=9,dz=9,type=marker] Pos[0] 1000
execute store result score #dir_y sgp.dummy run data get entity @e[tag=sgp.aim_vector,limit=1,x=-3,y=-3,z=-3,dx=9,dy=9,dz=9,type=marker] Pos[1] 1000
execute store result score #dir_z sgp.dummy run data get entity @e[tag=sgp.aim_vector,limit=1,x=-3,y=-3,z=-3,dx=9,dy=9,dz=9,type=marker] Pos[2] 1000

# Cleanup the marker
kill @e[tag=sgp.aim_vector,limit=1,x=-3,y=-3,z=-3,dx=9,dy=9,dz=9,type=marker]

# If the projectile is a potion, make it shoot more upwards
execute if entity @s[type=splash_potion] run scoreboard players operation #dir_y sgp.dummy += 300 sgp.dummy

# Multiply the directional vector by the original speed
# Both values are scaled by 1000, so the result of multiplying them has a scale of 1,000,000
scoreboard players operation #dir_x sgp.dummy *= $vector.length bs.out
scoreboard players operation #dir_y sgp.dummy *= $vector.length bs.out
scoreboard players operation #dir_z sgp.dummy *= $vector.length bs.out

# Store the result back into the projectile's Motion
# We use a scale multiplier of 0.000001 (which is 1 / 1,000,000) to safely cast the math back to the correct double value
execute store result entity @s Motion[0] double 0.000001 run scoreboard players get #dir_x sgp.dummy
execute store result entity @s Motion[1] double 0.000001 run scoreboard players get #dir_y sgp.dummy
execute store result entity @s Motion[2] double 0.000001 run scoreboard players get #dir_z sgp.dummy