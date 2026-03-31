tellraw @a[tag=sgp.in_game] [{"storage":"sgp.text", "nbt":"prefix", "interpret":true}, {"translate":"sgp.mineurs:confinement_prefix", "fallback":"CONFINEMENT ! ", "bold":true}, {"translate":"sgp.mineurs:confinement_message", "fallback":"Le Canarchimage a répandu la Grippe Aviaire dans l'arène ! \n     Vous avez %s pour rentrer en intérieur, ou vous mourrez !", "color":"white", "with":[{"translate":"sgp.mineurs:confinement_15_seconds", "fallback":"15 secondes", "color":"red", "bold":true}]}]

title @a[tag=sgp.in_game] title {"translate":"sgp.mineurs:confinement_title", "fallback":"CONFINEMENT!", "color":"gray", "bold":true}

execute at @e[type=marker,tag=sgp.marker,name="pvp_arena",limit=1] \
    run playsound minecraft:music_disc.strad master @a[tag=sgp.in_game] ~ ~ ~ 100

experience set @a[tag=sgp.in_game] 181 levels

schedule function sgp.mineurs:confinement/running 15s