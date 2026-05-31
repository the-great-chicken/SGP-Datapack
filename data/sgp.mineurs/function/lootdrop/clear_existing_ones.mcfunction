#> sgp.mineurs:lootdrop/clear_existing_ones

execute as @e[type=marker,tag=sgp.marker,name="Lootdrop"] at @s \
    run setblock ~ ~ ~ air
kill @e[name=lootdrop_beacon,type=text_display]
kill @e[name=lootdrop_glowing_chest,type=block_display]