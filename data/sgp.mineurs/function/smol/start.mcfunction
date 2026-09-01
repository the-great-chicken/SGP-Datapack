#> sgp.mineurs:smol/start

title @a[tag=sgp.in_game] title {text:"SMOL!", color:dark_blue, bold:true}
tellraw @a[tag=sgp.in_game] [{storage:"sgp:text", nbt:"prefix", interpret:true}, {text:"SMOL! ", color:dark_blue, bold:true},{text:"Le Canarchimage a divisé la taille de tout le monde par 2 !", color:blue}]

execute as @a[tag=sgp.in_game] \
    run attribute @s minecraft:scale modifier add sgp.smol -0.5 add_multiplied_total

function sgp.misc:timer_experience {duration:150}
schedule function sgp.mineurs:smol/end 150s