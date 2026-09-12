#> sgp.ci:illusions_movement/formation
# `{group: fixture group}`
#
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

$execute store result score #ci.illusion.created sgp.dummy if entity @e[tag=sgp.ci.illusion_$(group),distance=..0.1,type=mannequin]
assert score #ci.illusion.created sgp.dummy matches 3
$execute as @n[tag=sgp.ci.illusion_$(group),tag=sgp.direction_left,distance=..0.1,type=mannequin] run function sgp.ci:illusions_movement/remember_decoy {group:$(group),direction:left}
$execute as @n[tag=sgp.ci.illusion_$(group),tag=sgp.direction_right,distance=..0.1,type=mannequin] run function sgp.ci:illusions_movement/remember_decoy {group:$(group),direction:right}
$execute as @n[tag=sgp.ci.illusion_$(group),tag=sgp.direction_opposite,distance=..0.1,type=mannequin] run function sgp.ci:illusions_movement/remember_decoy {group:$(group),direction:opposite}
