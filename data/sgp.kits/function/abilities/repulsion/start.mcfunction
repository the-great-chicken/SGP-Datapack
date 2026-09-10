#> sgp.kits:abilities/repulsion/start

execute store result score @s sgp.cooldown_ability run data get storage sgp:data kits.ability_cooldowns.repulsion.cooldown
function sgp.kits:stats_collector/ability/start {kit_id:2,ability_path:"repulsion"}

# Capture the launch position at milliblock precision. The scheduled callback
# removes the temporary gravity modifier and measures net 3D displacement.
function #bs.position:get_pos {scale:1000}
scoreboard players operation @s sgp.old_x = @s bs.pos.x
scoreboard players operation @s sgp.old_y = @s bs.pos.y
scoreboard players operation @s sgp.old_z = @s bs.pos.z

# Fire a free, unenchanted full-speed arrow in the direction the Archer is looking.
execute anchored eyes positioned ^ ^ ^ positioned ~ ~-0.1 ~ run summon arrow ~ ~ ~ {Motion:[0.0d,0.0d,3.0d],damage:2.0d,crit:0b,pickup:0b,Tags:["sgp.repulsion_arrow","sgp.new"]}
data modify entity @n[tag=sgp.repulsion_arrow,tag=sgp.new,distance=..2,limit=1,type=arrow] Owner set from entity @s UUID
# Make the arrow have the correct rotation
execute store result entity @n[tag=sgp.repulsion_arrow,tag=sgp.new,distance=..2,limit=1,type=arrow] Rotation[0] float -0.001 run data get entity @s Rotation[0] 1000
execute store result entity @n[tag=sgp.repulsion_arrow,tag=sgp.new,distance=..2,limit=1,type=arrow] Rotation[1] float -0.001 run data get entity @s Rotation[1] 1000
execute as @n[tag=sgp.repulsion_arrow,tag=sgp.new,distance=..2,limit=1,type=arrow] run function sgp.kits:projectile/reset_velocity
tag @n[tag=sgp.repulsion_arrow,tag=sgp.new,distance=..2,limit=1,type=arrow] remove sgp.new

# Trigger the enchantment (apply_impulse is only available on them)
scoreboard players set @s sgp.trigger_repulsion 1

playsound entity.arrow.shoot master @a ~ ~ ~ 1 1
playsound entity.blaze.shoot master @a ~ ~ ~ 1 1

particle minecraft:firework ~ ~0.1 ~ 0.1 0 0.1 0.2 20 force
particle minecraft:sonic_boom ~ ~0.3 ~ 0.18 0.18 0.18 0 3 force @a
execute positioned ~ ~1 ~ run particle minecraft:sonic_boom ^ ^ ^-1 0.18 0.18 0.18 0 3 force @a
execute positioned ~ ~2 ~ run particle minecraft:sonic_boom ^ ^ ^-2 0.18 0.18 0.18 0 3 force @a
execute positioned ~ ~2.5 ~ run particle minecraft:sonic_boom ^ ^ ^-3 0.18 0.18 0.18 0 3 force @a

attribute @s gravity modifier add sgp.kits:repulsion -0.7 add_multiplied_total

function #bs.schedule:schedule {run:"function sgp.kits:abilities/repulsion/measure",with:{time:10,unit:"t"}}
