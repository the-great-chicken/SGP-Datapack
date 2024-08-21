title @a[tag=sgp.in_game] title {"text":"LOOTDROP!","color":"gold","bold":true}

tellraw @a[tag=sgp.in_game] [{"storage":"sgp.text", "nbt":"prefix", "interpret":true}, {"text":"LOOTDROP! ", "color":"gold", "bold":true}, {"text":"Le Grand Poulet a fait apparaitre un coffre contenant du loot précieux quelque part sur la map !","color":"yellow"}]

execute as @e[type=marker,tag=sgp.marker,name="Lootdrop",limit=1,sort=random] at @s \
    run setblock ~ ~ ~ minecraft:trapped_chest{LootTable:"sgp.mineurs:lootdrop_chest"} replace