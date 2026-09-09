#> sgp.ci:diorama_hover/fixture
fill ~ ~1 ~ ~10 ~5 ~10 air
fill ~ ~ ~ ~10 ~ ~10 stone
gamemode survival @s
tp @s ~3.5 ~1 ~1.5 0 0
tag @s add sgp.around_current_model
summon marker ~1 ~1 ~1 {Tags:["sgp.ci.hover"],data:{id:93001}}
summon interaction ~3.5 ~1 ~5.5 {Tags:["sgp.ci.hover","sgp.ci.hover_first"],width:1f,height:3f}
summon interaction ~8.5 ~1 ~5.5 {Tags:["sgp.ci.hover","sgp.ci.hover_second"],width:1f,height:3f}
scoreboard players set @e[tag=sgp.ci.hover_first,distance=..16,type=interaction] bs.id 93011
scoreboard players set @e[tag=sgp.ci.hover_second,distance=..16,type=interaction] bs.id 93012
scoreboard players set @e[tag=sgp.ci.hover,distance=..16,type=interaction] sgp.hover_time 0
summon text_display ~3.5 ~1 ~5.5 {Tags:["sgp.ci.hover","sgp.ci.hover_first","sgp.spawn_tper_text"],text:"First",transformation:{translation:[0f,0f,0f],left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],scale:[0.55f,0.55f,0.55f]}}
summon text_display ~8.5 ~1 ~5.5 {Tags:["sgp.ci.hover","sgp.ci.hover_second","sgp.spawn_tper_text"],text:"Second",transformation:{translation:[0f,0f,0f],left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],scale:[0.55f,0.55f,0.55f]}}
scoreboard players set @e[tag=sgp.ci.hover_first,distance=..16,type=text_display] bs.link.to 93011
scoreboard players set @e[tag=sgp.ci.hover_second,distance=..16,type=text_display] bs.link.to 93012
# An overlapping unrelated display must never be resized instead of the linked label.
summon text_display ~3.5 ~1 ~5.5 {Tags:["sgp.ci.hover","sgp.ci.hover_unrelated","sgp.spawn_tper_text"],text:"Unrelated",transformation:{translation:[0f,0f,0f],left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],scale:[1f,1f,1f]}}
scoreboard players set @e[tag=sgp.ci.hover_unrelated,distance=..16,type=text_display] bs.link.to 93013
data modify storage sgp:data misc.diorama.spawn_interactions.id_93001 set value []
execute as @e[tag=sgp.ci.hover,distance=..16,type=interaction] run function sgp.ci:diorama_hover/cache

function sgp.ci:diorama_hover/expect {target:first,active:0,scale:0.55}
function sgp.ci:diorama_hover/expect {target:second,active:0,scale:0.55}
