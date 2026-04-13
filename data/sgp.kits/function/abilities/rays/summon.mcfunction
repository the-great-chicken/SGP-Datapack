#> sgp.kits:abilities/rays/summon

scoreboard players set @s sgp.cooldown_ability 200
tag @s add sgp.is_radiating

summon item_display ~ ~0.6 ~ {Tags:["sgp.ray","sgp.south"], item:{id:"minecraft:yellow_stained_glass",count:1}, item_display:"fixed", teleport_duration:1, interpolation_duration:0, transformation:{translation:[0.0f, 0.0f, 8.0f], scale:[1.0f, 1.0f, 32.0f], left_rotation:[0f,0f,1f,1f], right_rotation:[0f,0f,0f,1f]}}

summon item_display ~ ~0.6 ~ {Tags:["sgp.ray","sgp.north"], item:{id:"minecraft:yellow_stained_glass",count:1}, item_display:"fixed", teleport_duration:1, interpolation_duration:0, transformation:{translation:[0.0f, 0.0f, 8.0f], scale:[1.0f, 1.0f, 32.0f], left_rotation:[0f,0f,-1f,1f], right_rotation:[0f,0f,0f,1f]}, Rotation:[180,0]}

summon item_display ~ ~0.6 ~ {Tags:["sgp.ray","sgp.east"], item:{id:"minecraft:yellow_stained_glass",count:1}, item_display:"fixed", teleport_duration:1, interpolation_duration:0, transformation:{translation:[0.0f, 0.0f, 8.0f], scale:[1.0f, 1.0f, 32.0f], left_rotation:[0f,0f,1f,1f], right_rotation:[0f,0f,0f,1f]}, Rotation:[-90,0]}

summon item_display ~ ~0.6 ~ {Tags:["sgp.ray","sgp.west"], item:{id:"minecraft:yellow_stained_glass",count:1}, item_display:"fixed", teleport_duration:1, interpolation_duration:0, transformation:{translation:[0.0f, 0.0f, 8.0f], scale:[1.0f, 1.0f, 32.0f], left_rotation:[0f,0f,-1f,1f], right_rotation:[0f,0f,0f,1f]}, Rotation:[90,0]}

summon item_display ~ ~0.6 ~ {Tags:["sgp.ray","sgp.south_west"], item:{id:"minecraft:yellow_stained_glass",count:1}, item_display:"fixed", teleport_duration:1, interpolation_duration:0, transformation:{translation:[0.0f, 0.0f, 8.0f], scale:[1.0f, 1.0f, 32.0f], left_rotation:[0f,0f,1f,1f], right_rotation:[0f,0f,0f,1f]}, Rotation:[45,0]}

summon item_display ~ ~0.6 ~ {Tags:["sgp.ray","sgp.north_east"], item:{id:"minecraft:yellow_stained_glass",count:1}, item_display:"fixed", teleport_duration:1, interpolation_duration:0, transformation:{translation:[0.0f, 0.0f, 8.0f], scale:[1.0f, 1.0f, 32.0f], left_rotation:[0f,0f,-1f,1f], right_rotation:[0f,0f,0f,1f]}, Rotation:[-135,0]}

summon item_display ~ ~0.6 ~ {Tags:["sgp.ray","sgp.south_east"], item:{id:"minecraft:yellow_stained_glass",count:1}, item_display:"fixed", teleport_duration:1, interpolation_duration:0, transformation:{translation:[0.0f, 0.0f, 8.0f], scale:[1.0f, 1.0f, 32.0f], left_rotation:[0f,0f,1f,1f], right_rotation:[0f,0f,0f,1f]}, Rotation:[-45,0]}

summon item_display ~ ~0.6 ~ {Tags:["sgp.ray","sgp.north_west"], item:{id:"minecraft:yellow_stained_glass",count:1}, item_display:"fixed", teleport_duration:1, interpolation_duration:0, transformation:{translation:[0.0f, 0.0f, 8.0f], scale:[1.0f, 1.0f, 32.0f], left_rotation:[0f,0f,-1f,1f], right_rotation:[0f,0f,0f,1f]}, Rotation:[135,0]}

scoreboard players set @e[type=item_display,tag=sgp.ray,sort=nearest,limit=8] sgp.timer 70