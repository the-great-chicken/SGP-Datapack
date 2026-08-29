#> sgp.kits:abilities/repulsion/start

execute store result score @s sgp.cooldown_ability run data get storage sgp:data kits.ability_cooldowns.repulsion.cooldown
function sgp.kits:stats_collector/ability/start {kit_id:2,ability_path:"repulsion"}

# Capture the launch position at milliblock precision. The scheduled callback
# removes the temporary gravity modifier and measures net 3D displacement.
function #bs.position:get_pos {scale:1000}
scoreboard players operation @s sgp.old_x = @s bs.pos.x
scoreboard players operation @s sgp.old_y = @s bs.pos.y
scoreboard players operation @s sgp.old_z = @s bs.pos.z

# Trigger the enchantment (apply_impulse is only available on them)
scoreboard players set @s sgp.trigger_repulsion 1

playsound entity.blaze.shoot master @a ~ ~ ~ 1 1
particle minecraft:sonic_boom ~ ~0.5 ~ 0.2 0.2 0.2 0 10 force @a

function #bs.schedule:schedule {run:"function sgp.kits:abilities/repulsion/measure",with:{time:10,unit:"t"}}
