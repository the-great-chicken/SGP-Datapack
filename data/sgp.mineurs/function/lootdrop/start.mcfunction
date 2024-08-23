#> sgp.mineurs:lootdrop/start
#
# Beginning of the lootdrop "minor event"
# Announces it, removes the potentially existing lootdrop, and summons a new one

title @a[tag=sgp.in_game] title {"text":"LOOTDROP!","color":"gold","bold":true}
tellraw @a[tag=sgp.in_game] [{"storage":"sgp.text", "nbt":"prefix", "interpret":true}, {"text":"LOOTDROP! ", "color":"gold", "bold":true}, {"text":"Le Grand Poulet a fait apparaitre un coffre contenant du loot précieux quelque part sur la map !","color":"yellow"}]

execute as @e[type=marker,tag=sgp.marker,name="Lootdrop"] at @s \
    run setblock ~ ~ ~ air
    
execute as @e[type=marker,tag=sgp.marker,name="Lootdrop",limit=1,sort=random] at @s \
    run function sgp.mineurs:lootdrop/summon_chest