tellraw @a[tag=sgp.in_game] [{"storage":"sgp.text", "nbt":"prefix", "interpret":true}, {"text":"CONFINEMENT ! ", "bold":true}, {"text":"Le Canarchimage a répandu la Grippe Aviaire dans l'arène ! \n \
    Vous avez ", "color":"white"}, {"text":"15 secondes", "color":"red", "bold":true}, {"text":" pour rentrer en intérieur, ou vous mourrez !", "color":"white"}]

title @a[tag=sgp.in_game] title {"text":"CONFINEMENT!", "color":"gray", "bold":true}

execute at @e[type=marker,tag=sgp.marker,name="pvp_arena",limit=1] \
    run playsound minecraft:music_disc.strad master @a[tag=sgp.in_game] ~ ~ ~ 100

experience set @a[tag=sgp.in_game] 181 levels

schedule function sgp.mineurs:confinement/running 15s