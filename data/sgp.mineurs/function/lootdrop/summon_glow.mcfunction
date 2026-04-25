#> sgp.mineurs:lootdrop/summon_glow

execute if block ~ ~ ~ trapped_chest[facing=north] \
    run summon block_display ~0.5 ~ ~0.5 {CustomName:"lootdrop_glowing_chest", block_state:{Name:"minecraft:chest"}, Glowing:1b, glow_color_override:16755200, Rotation:[180f,0f], transformation:{left_rotation:[0f,0f,0f,1f], right_rotation:[0f,0f,0f,1f], translation:[0.0005f, 0.0005f, 0.0005f], scale:[0.999f, 0.999f, 0.999f]}, view_range:0.2}
    
execute if block ~ ~ ~ trapped_chest[facing=south] \
    run summon block_display ~-0.5 ~ ~-0.5 {CustomName:"lootdrop_glowing_chest", block_state:{Name:"minecraft:chest"}, Glowing:1b, glow_color_override:16755200, Rotation:[0f,0f], transformation:{left_rotation:[0f,0f,0f,1f], right_rotation:[0f,0f,0f,1f], translation:[0.0005f, 0.0005f, 0.0005f], scale:[0.999f, 0.999f, 0.999f]}, view_range:0.2}

execute if block ~ ~ ~ trapped_chest[facing=west] \
    run summon block_display ~0.5 ~ ~-0.5 {CustomName:"lootdrop_glowing_chest", block_state:{Name:"minecraft:chest"}, Glowing:1b, glow_color_override:16755200, Rotation:[90f,0f], transformation:{left_rotation:[0f,0f,0f,1f], right_rotation:[0f,0f,0f,1f], translation:[0.0005f, 0.0005f, 0.0005f], scale:[0.999f, 0.999f, 0.999f]}, view_range:0.2}

execute if block ~ ~ ~ trapped_chest[facing=east] \
    run summon block_display ~-0.5 ~ ~0.5 {CustomName:"lootdrop_glowing_chest", block_state:{Name:"minecraft:chest"}, Glowing:1b, glow_color_override:16755200, Rotation:[-90f,0f], transformation:{left_rotation:[0f,0f,0f,1f], right_rotation:[0f,0f,0f,1f], translation:[0.0005f, 0.0005f, 0.0005f], scale:[0.999f, 0.999f, 0.999f]}, view_range:0.2}
tag @s add sgp.glow_spawned