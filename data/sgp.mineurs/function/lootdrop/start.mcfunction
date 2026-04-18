#> sgp.mineurs:lootdrop/start
#
# Beginning of the lootdrop "minor event"
# Announces it, removes the potentially existing lootdrops, and summons a new one

title @a[tag=sgp.in_game] title {text:"LOOTDROP!",color:gold,bold:true}
tellraw @a[tag=sgp.in_game] [{storage:"sgp.text", nbt:"prefix", interpret:true}, {text:"LOOTDROP! ", color:gold, bold:true}, {text:"Le Grand Poulet a fait apparaitre 2 coffres contenant du loot précieux quelque part sur la map !",color:yellow}]

execute as @e[type=marker,tag=sgp.marker,name="Lootdrop"] at @s \
    run setblock ~ ~ ~ air
    
execute as @e[type=marker,tag=sgp.marker,name="Lootdrop",limit=2,sort=random] at @s \
    run function sgp.mineurs:lootdrop/summon_chest

# summon text_display ~ ~-60 ~ {CustomName:lootdrop_beacon, see_through: 1b, background: 0, billboard: "vertical", text: {text:"🮕🮕🮕🮕🮕🮕🮕🮕🮕🮕🮕🮕🮕🮕🮕🮕🮕🮕🮕🮕🮕🮕🮕🮕🮕🮕🮕🮕🮕🮕🮕🮕🮕🮕🮕🮕🮕🮕🮕🮕🮕🮕🮕🮕🮕🮕🮕🮕🮕🮕🮕🮕🮕🮕🮕🮕🮕🮕🮕", color:"#ffd735"},transformation:{left_rotation:{angle:0.7854f, axis:[0f,1f,0f]}, right_rotation:[0f,0f,0f,1f], translation:[-0.071f, 0f, 0.071f], scale:[8f,8f,8f]},line_width:1,brightness:{block:15,sky:15},view_range:5.0,text_opacity:200}
# summon text_display ~ ~-60 ~ {CustomName:lootdrop_beacon, see_through: 1b, background: 0, billboard: "vertical", text: {text:"🮖🮖🮖🮖🮖🮖🮖🮖🮖🮖🮖🮖🮖🮖🮖🮖🮖🮖🮖🮖🮖🮖🮖🮖🮖🮖🮖🮖🮖🮖🮖🮖🮖🮖🮖🮖🮖🮖🮖🮖🮖🮖🮖🮖🮖🮖🮖🮖🮖🮖🮖🮖🮖🮖🮖🮖🮖🮖🮖", color:"#ffd735"},transformation:{left_rotation:{angle:-0.7854f, axis:[0f,1f,0f]}, right_rotation:[0f,0f,0f,1f], translation:[-0.071f, 0f, -0.071f], scale:[8f,8f,8f]},line_width:1,brightness:{block:15,sky:15},view_range:5.0,text_opacity:200}