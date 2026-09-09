#> sgp.ci:diorama_lifecycle/fixture
gamemode survival @s
tp @s 60.0 81.0 60.0
clear @s
function #bs.id:give_suid
summon marker 32.0 80.0 32.0 {Tags:["sgp.ci.diorama_lifecycle","sgp.ci.lifecycle_map","sgp.marker"],CustomName:"playable_map",data:{id:96001,dx:7,dy:7,dz:7}}
summon marker 8.0 80.0 8.0 {Tags:["sgp.ci.diorama_lifecycle","sgp.ci.lifecycle_model","sgp.marker"],CustomName:"playable_map_model",data:{id:96001,mdx:3,mdy:3,mdz:3,mdx_end:11,mdy_end:11,mdz_end:11}}
execute as @n[tag=sgp.ci.lifecycle_model,type=marker] run function #bs.id:give_suid
scoreboard players operation @n[tag=sgp.ci.lifecycle_map,type=marker] bs.link.to = @n[tag=sgp.ci.lifecycle_model,type=marker] bs.id
