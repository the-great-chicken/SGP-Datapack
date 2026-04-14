#> sgp.kits:abilities/illusions/summon
#
# `{current_uuid: player UUID, current_direction: right|left|opposite}`

$summon mannequin ~ ~ ~ {profile: {id: $(current_uuid)}, Tags:["sgp.illusion_init", "sgp.illusion", "sgp.direction_$(current_direction)"], CustomNameVisible:true, description:{text:"20 ",extra:[{text:"❤", color:red}]}, Health:2}
$execute as @e[tag=sgp.illusion_init,tag=sgp.direction_$(current_direction),distance=..0.1,limit=1,type=mannequin] at @p run function sgp.kits:abilities/illusions/link

# Give player's name to illusion
summon text_display ~ ~ ~ {Tags:["sgp.temp_name"], text:{selector:"@p[scores={sgp.drop_any=1..},tag=sgp.alchimiste]"}}

$data modify entity @e[tag=sgp.illusion_init,tag=sgp.direction_$(current_direction),distance=..0.1,limit=1,type=mannequin] CustomName set from entity @e[tag=sgp.temp_name,limit=1,distance=..0.1,type=text_display] text

kill @e[tag=sgp.temp_name,distance=..0.1,type=text_display]