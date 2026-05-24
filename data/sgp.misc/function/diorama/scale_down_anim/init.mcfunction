#> sgp.misc:diorama/scale_down_anim/init
# `{init_yaw, init_pitch: int}`

execute unless score @s sgp.id matches 1.. \
    store result score @s sgp.id \
        run scoreboard players add #global sgp.id 1
execute store result storage sgp:macro diorama/scale_down_anim.id int 1 run scoreboard players get @s sgp.id

summon marker ~ ~ ~ {Tags:["sgp.anim_target", "sgp.new"]}
scoreboard players operation @e[tag=sgp.new,distance=..0.1,limit=1,type=marker] sgp.id = @s sgp.id
tag @e[tag=sgp.new,distance=..0.1,limit=1,type=marker] remove sgp.new

$execute at @s anchored eyes positioned ^ ^ ^ \
    run summon block_display ~ ~ ~ {Tags:["sgp.cam", "sgp.new"], teleport_duration:16, block_state:{Name:"minecraft:air"},width:0.01,height:0.01, Rotation:[$(init_yaw),$(init_pitch)]}
execute at @s anchored eyes positioned ^ ^ ^ \
    run scoreboard players operation @e[tag=sgp.cam,distance=..0.1,limit=1,type=block_display] sgp.id = @s sgp.id
execute at @s anchored eyes positioned ^ ^ ^ \
    run tag @e[tag=sgp.new,distance=..0.1,limit=1,type=block_display] remove sgp.new

# Change this value to increase or decrease the animation duration
scoreboard players set @s sgp.anim_timer 20
gamemode spectator @s

function sgp.misc:diorama/scale_down_anim/launch with storage sgp:macro diorama/scale_down_anim