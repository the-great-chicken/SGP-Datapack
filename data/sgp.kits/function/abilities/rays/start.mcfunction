#> sgp.kits:abilities/rays/start

execute store result score @s sgp.cooldown_ability run data get storage sgp:data kits.ability_cooldowns.rays.cooldown
execute store result score @s sgp.duration_ability run data get storage sgp:data kits.ability_cooldowns.rays.duration

summon item_display ~ ~0.6 ~ {Tags:["sgp.ray","sgp.south","sgp.new"], item:{id:"minecraft:yellow_stained_glass",count:1}, item_display:"fixed", teleport_duration:2, transformation:{translation:[0.0f, 0.0f, 8.0f], scale:[0.5f, 0.5f, 32.0f], left_rotation:[0f,0f,1f,1f], right_rotation:[0f,0f,0f,1f]}}

summon item_display ~ ~0.6 ~ {Tags:["sgp.ray","sgp.north","sgp.new"], item:{id:"minecraft:yellow_stained_glass",count:1}, item_display:"fixed", teleport_duration:2, transformation:{translation:[0.0f, 0.0f, 8.0f], scale:[0.5f, 0.5f, 32.0f], left_rotation:[0f,0f,-1f,1f], right_rotation:[0f,0f,0f,1f]}, Rotation:[180,0]}

summon item_display ~ ~0.6 ~ {Tags:["sgp.ray","sgp.east","sgp.new"], item:{id:"minecraft:yellow_stained_glass",count:1}, item_display:"fixed", teleport_duration:2, transformation:{translation:[0.0f, 0.0f, 8.0f], scale:[0.5f, 0.5f, 32.0f], left_rotation:[0f,0f,1f,1f], right_rotation:[0f,0f,0f,1f]}, Rotation:[-90,0]}

summon item_display ~ ~0.6 ~ {Tags:["sgp.ray","sgp.west","sgp.new"], item:{id:"minecraft:yellow_stained_glass",count:1}, item_display:"fixed", teleport_duration:2, transformation:{translation:[0.0f, 0.0f, 8.0f], scale:[0.5f, 0.5f, 32.0f], left_rotation:[0f,0f,-1f,1f], right_rotation:[0f,0f,0f,1f]}, Rotation:[90,0]}

summon item_display ~ ~0.6 ~ {Tags:["sgp.ray","sgp.south_west","sgp.new"], item:{id:"minecraft:yellow_stained_glass",count:1}, item_display:"fixed", teleport_duration:2, transformation:{translation:[0.0f, 0.0f, 8.0f], scale:[0.5f, 0.5f, 32.0f], left_rotation:[0f,0f,1f,1f], right_rotation:[0f,0f,0f,1f]}, Rotation:[45,0]}

summon item_display ~ ~0.6 ~ {Tags:["sgp.ray","sgp.north_east","sgp.new"], item:{id:"minecraft:yellow_stained_glass",count:1}, item_display:"fixed", teleport_duration:2, transformation:{translation:[0.0f, 0.0f, 8.0f], scale:[0.5f, 0.5f, 32.0f], left_rotation:[0f,0f,-1f,1f], right_rotation:[0f,0f,0f,1f]}, Rotation:[-135,0]}

summon item_display ~ ~0.6 ~ {Tags:["sgp.ray","sgp.south_east","sgp.new"], item:{id:"minecraft:yellow_stained_glass",count:1}, item_display:"fixed", teleport_duration:2, transformation:{translation:[0.0f, 0.0f, 8.0f], scale:[0.5f, 0.5f, 32.0f], left_rotation:[0f,0f,1f,1f], right_rotation:[0f,0f,0f,1f]}, Rotation:[-45,0]}

summon item_display ~ ~0.6 ~ {Tags:["sgp.ray","sgp.north_west","sgp.new"], item:{id:"minecraft:yellow_stained_glass",count:1}, item_display:"fixed", teleport_duration:2, transformation:{translation:[0.0f, 0.0f, 8.0f], scale:[0.5f, 0.5f, 32.0f], left_rotation:[0f,0f,-1f,1f], right_rotation:[0f,0f,0f,1f]}, Rotation:[135,0]}

execute as @e[tag=sgp.new,distance=..2,predicate=!bs.link:has_link,limit=8,type=item_display] run function #bs.link:create_link_ata
function #bs.link:as_children {run:"scoreboard players set @s[tag=sgp.ray,tag=sgp.new] sgp.timer 70"}
function #bs.link:as_children {run:"tag @s[tag=sgp.ray,tag=sgp.new] remove sgp.new"}

function #bs.position:get_pos {scale:1000}
scoreboard players operation @s sgp.old_x = @s bs.pos.x
scoreboard players operation @s sgp.old_y = @s bs.pos.y
scoreboard players operation @s sgp.old_z = @s bs.pos.z