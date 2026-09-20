#> sgp.kits:abilities/rays/init
# Create the beams and initialize their tracking from the caster.

scoreboard players set @s sgp.ray_anim 70

summon item_display ~ ~0.6 ~ {Tags:["sgp.ray","sgp.ray_cardinal","sgp.south","sgp.new"], item:{id:"minecraft:yellow_stained_glass",count:1}, item_display:"fixed", teleport_duration:2, transformation:{translation:[0.0f, 0.0f, 8.0f], scale:[0.5f, 0.5f, 32.0f], left_rotation:[0f,0f,1f,1f], right_rotation:[0f,0f,0f,1f]}}

summon item_display ~ ~0.6 ~ {Tags:["sgp.ray","sgp.ray_cardinal","sgp.north","sgp.new"], item:{id:"minecraft:yellow_stained_glass",count:1}, item_display:"fixed", teleport_duration:2, transformation:{translation:[0.0f, 0.0f, 8.0f], scale:[0.5f, 0.5f, 32.0f], left_rotation:[0f,0f,-1f,1f], right_rotation:[0f,0f,0f,1f]}, Rotation:[180,0]}

summon item_display ~ ~0.6 ~ {Tags:["sgp.ray","sgp.ray_cardinal","sgp.east","sgp.new"], item:{id:"minecraft:yellow_stained_glass",count:1}, item_display:"fixed", teleport_duration:2, transformation:{translation:[0.0f, 0.0f, 8.0f], scale:[0.5f, 0.5f, 32.0f], left_rotation:[0f,0f,1f,1f], right_rotation:[0f,0f,0f,1f]}, Rotation:[-90,0]}

summon item_display ~ ~0.6 ~ {Tags:["sgp.ray","sgp.ray_cardinal","sgp.west","sgp.new"], item:{id:"minecraft:yellow_stained_glass",count:1}, item_display:"fixed", teleport_duration:2, transformation:{translation:[0.0f, 0.0f, 8.0f], scale:[0.5f, 0.5f, 32.0f], left_rotation:[0f,0f,-1f,1f], right_rotation:[0f,0f,0f,1f]}, Rotation:[90,0]}

summon item_display ~ ~0.6 ~ {Tags:["sgp.ray","sgp.south_west","sgp.new"], item:{id:"minecraft:yellow_stained_glass",count:1}, item_display:"fixed", teleport_duration:2, transformation:{translation:[0.0f, 0.0f, 8.0f], scale:[0.5f, 0.5f, 32.0f], left_rotation:[0f,0f,1f,1f], right_rotation:[0f,0f,0f,1f]}, Rotation:[45,0]}

summon item_display ~ ~0.6 ~ {Tags:["sgp.ray","sgp.north_east","sgp.new"], item:{id:"minecraft:yellow_stained_glass",count:1}, item_display:"fixed", teleport_duration:2, transformation:{translation:[0.0f, 0.0f, 8.0f], scale:[0.5f, 0.5f, 32.0f], left_rotation:[0f,0f,-1f,1f], right_rotation:[0f,0f,0f,1f]}, Rotation:[-135,0]}

summon item_display ~ ~0.6 ~ {Tags:["sgp.ray","sgp.south_east","sgp.new"], item:{id:"minecraft:yellow_stained_glass",count:1}, item_display:"fixed", teleport_duration:2, transformation:{translation:[0.0f, 0.0f, 8.0f], scale:[0.5f, 0.5f, 32.0f], left_rotation:[0f,0f,1f,1f], right_rotation:[0f,0f,0f,1f]}, Rotation:[-45,0]}

summon item_display ~ ~0.6 ~ {Tags:["sgp.ray","sgp.north_west","sgp.new"], item:{id:"minecraft:yellow_stained_glass",count:1}, item_display:"fixed", teleport_duration:2, transformation:{translation:[0.0f, 0.0f, 8.0f], scale:[0.5f, 0.5f, 32.0f], left_rotation:[0f,0f,-1f,1f], right_rotation:[0f,0f,0f,1f]}, Rotation:[135,0]}

execute as @e[tag=sgp.new,distance=..2,predicate=!bs.link:has_link,limit=8,type=item_display] run function #bs.link:create_link_ata
scoreboard players operation $link.to bs.in = @s bs.id
execute as @e[tag=sgp.ray,tag=sgp.new,distance=..2,predicate=bs.link:link_equal,limit=8,type=item_display] run function sgp.kits:abilities/rays/init_child

function #bs.position:get_pos {scale:1000}
scoreboard players operation @s sgp.old_x = @s bs.pos.x
scoreboard players operation @s sgp.old_y = @s bs.pos.y
scoreboard players operation @s sgp.old_z = @s bs.pos.z
