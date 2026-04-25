#> sgp.mineurs:lootdrop/start
#
# Beginning of the lootdrop "minor event"
# Announces it, removes the potentially existing lootdrops, and summons a new one

title @a[tag=sgp.in_game] title {text:"LOOTDROP!",color:gold,bold:true}
tellraw @a[tag=sgp.in_game] [{storage:"sgp.text", nbt:"prefix", interpret:true}, {text:"LOOTDROP! ", color:gold, bold:true}, \
    {translate:"Le Grand Poulet a fait apparaitre %s contenant du loot précieux quelque part sur la map !",color:yellow, with:[{text:"2 coffres", color:green}]}]

execute as @e[type=marker,tag=sgp.marker,name="Lootdrop"] at @s \
    run setblock ~ ~ ~ air
kill @e[name=lootdrop_beacon,type=text_display]
kill @e[name=lootdrop_glowing_chest,type=block_display]
    
execute as @e[type=marker,tag=sgp.marker,name="Lootdrop",limit=2,sort=random] at @s \
    run function sgp.mineurs:lootdrop/summon_chest

function sgp.mineurs:lootdrop/check_for_players_around_chest