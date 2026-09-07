#> sgp.ci:illusions_movement/formation
# {group}
# Establish an active cast's linked center and three decoys without starting stats collection.

function #bs.id:give_suid
scoreboard players operation #ci.illusion.owner bs.in = @s bs.id
scoreboard players set @s sgp.duration_ability 100
$summon marker ~ ~ ~ {Tags:["sgp.ci.illusion","sgp.ci.illusion_new","sgp.ci.illusion_$(group)","sgp.illusion_center"]}
$summon mannequin ~ ~ ~ {Tags:["sgp.ci.illusion","sgp.ci.illusion_new","sgp.ci.illusion_$(group)","sgp.illusion","sgp.direction_left"],NoGravity:true}
$summon mannequin ~ ~ ~ {Tags:["sgp.ci.illusion","sgp.ci.illusion_new","sgp.ci.illusion_$(group)","sgp.illusion","sgp.direction_right"],NoGravity:true}
$summon mannequin ~ ~ ~ {Tags:["sgp.ci.illusion","sgp.ci.illusion_new","sgp.ci.illusion_$(group)","sgp.illusion","sgp.direction_opposite"],NoGravity:true}
execute as @e[tag=sgp.ci.illusion_new,distance=..0.1,type=marker] run scoreboard players operation @s bs.link.to = #ci.illusion.owner bs.in
execute as @e[tag=sgp.ci.illusion_new,distance=..0.1,type=mannequin] run scoreboard players operation @s bs.link.to = #ci.illusion.owner bs.in
tag @e[tag=sgp.ci.illusion_new,distance=..0.1,type=marker] remove sgp.ci.illusion_new
tag @e[tag=sgp.ci.illusion_new,distance=..0.1,type=mannequin] remove sgp.ci.illusion_new
