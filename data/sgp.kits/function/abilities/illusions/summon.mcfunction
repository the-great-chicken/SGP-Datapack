#> sgp.kits:abilities/illusions/summon
#
# `{current_uuid: player UUID, current_direction: right|left|opposite}`

$summon mannequin ~ ~ ~ {profile: {id: $(current_uuid)}, Tags:["sgp.illusion_init", "sgp.illusion", "sgp.direction_$(current_direction)"], CustomNameVisible:true, description:{text:"20 ",extra:[{text:"❤", color:red}]}, Health:2}
$data modify entity @n[type=mannequin,tag=sgp.direction_$(current_direction)] equipment.head.components."minecraft:enchantments"."sgp.kits:suffocation_immunity" set value 1