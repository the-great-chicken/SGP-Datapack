#> sgp.bench:scenarios/systems/diorama_ingame/setup
# `{first: int, last: int, players: int, lobby: int}`
#
# The playable map is the arena itself (64x16x64 from -32 80 -32), its 4x1x4 model sits at
# 0 121 0 with 16 spawn buttons, built through the production initialization path exactly
# like diorama_giant. Actors first..first+lobby-1 stand west of the model shell looking at
# the buttons; every other actor stays on its in-game grid slot inside the map.

$function sgp.bench:scenarios/systems/diorama_ingame/clear {first:$(first),last:$(last)}
data modify storage sgp:data spawns append value {id:99002,list:[]}
data modify storage sgp:data spawns[{id:99002}].list append value {x:-8.0d,y:81.0d,z:-8.0d,yaw:0.0f,pitch:0.0f,article:"au",title:{text:"Bench 01"},icon:"1"}
data modify storage sgp:data spawns[{id:99002}].list append value {x:0.0d,y:81.0d,z:-8.0d,yaw:0.0f,pitch:0.0f,article:"au",title:{text:"Bench 02"},icon:"1"}
data modify storage sgp:data spawns[{id:99002}].list append value {x:8.0d,y:81.0d,z:-8.0d,yaw:0.0f,pitch:0.0f,article:"au",title:{text:"Bench 03"},icon:"1"}
data modify storage sgp:data spawns[{id:99002}].list append value {x:16.0d,y:81.0d,z:-8.0d,yaw:0.0f,pitch:0.0f,article:"au",title:{text:"Bench 04"},icon:"1"}
data modify storage sgp:data spawns[{id:99002}].list append value {x:-8.0d,y:81.0d,z:0.0d,yaw:0.0f,pitch:0.0f,article:"au",title:{text:"Bench 05"},icon:"1"}
data modify storage sgp:data spawns[{id:99002}].list append value {x:0.0d,y:81.0d,z:0.0d,yaw:0.0f,pitch:0.0f,article:"au",title:{text:"Bench 06"},icon:"1"}
data modify storage sgp:data spawns[{id:99002}].list append value {x:8.0d,y:81.0d,z:0.0d,yaw:0.0f,pitch:0.0f,article:"au",title:{text:"Bench 07"},icon:"1"}
data modify storage sgp:data spawns[{id:99002}].list append value {x:16.0d,y:81.0d,z:0.0d,yaw:0.0f,pitch:0.0f,article:"au",title:{text:"Bench 08"},icon:"1"}
data modify storage sgp:data spawns[{id:99002}].list append value {x:-8.0d,y:81.0d,z:8.0d,yaw:0.0f,pitch:0.0f,article:"au",title:{text:"Bench 09"},icon:"1"}
data modify storage sgp:data spawns[{id:99002}].list append value {x:0.0d,y:81.0d,z:8.0d,yaw:0.0f,pitch:0.0f,article:"au",title:{text:"Bench 10"},icon:"1"}
data modify storage sgp:data spawns[{id:99002}].list append value {x:8.0d,y:81.0d,z:8.0d,yaw:0.0f,pitch:0.0f,article:"au",title:{text:"Bench 11"},icon:"1"}
data modify storage sgp:data spawns[{id:99002}].list append value {x:16.0d,y:81.0d,z:8.0d,yaw:0.0f,pitch:0.0f,article:"au",title:{text:"Bench 12"},icon:"1"}
data modify storage sgp:data spawns[{id:99002}].list append value {x:-8.0d,y:81.0d,z:16.0d,yaw:0.0f,pitch:0.0f,article:"au",title:{text:"Bench 13"},icon:"1"}
data modify storage sgp:data spawns[{id:99002}].list append value {x:0.0d,y:81.0d,z:16.0d,yaw:0.0f,pitch:0.0f,article:"au",title:{text:"Bench 14"},icon:"1"}
data modify storage sgp:data spawns[{id:99002}].list append value {x:8.0d,y:81.0d,z:16.0d,yaw:0.0f,pitch:0.0f,article:"au",title:{text:"Bench 15"},icon:"1"}
data modify storage sgp:data spawns[{id:99002}].list append value {x:16.0d,y:81.0d,z:16.0d,yaw:0.0f,pitch:0.0f,article:"au",title:{text:"Bench 16"},icon:"1"}
fill -4 120 -4 8 120 8 minecraft:bedrock
summon marker -32 80 -32 {Tags:["sgp.marker","sgp.bench.diorama_ig"],CustomName:"playable_map",data:{id:99002,dx:64,dy:16,dz:64}}
summon marker 0 121 0 {Tags:["sgp.marker","sgp.bench.diorama_ig"],CustomName:"playable_map_model",data:{id:99002}}
function sgp.diorama:init/markers
execute as @e[tag=sgp.bench.diorama_ig,name="playable_map_model",limit=1,type=marker] at @s run function sgp.diorama:spawn_entities/clear_and_recreate with entity @s data
execute positioned 0 121 0 run tag @e[tag=sgp.spawn_tper,distance=..8,type=interaction] add sgp.bench.diorama_ig_ui
execute positioned 0 121 0 run tag @e[tag=sgp.spawn_tper_text,distance=..8,type=text_display] add sgp.bench.diorama_ig_ui

# Lobby actors: a column west of the model, 1 block apart, facing east and slightly down at
# the buttons (the hover raycasts run whether or not they hit one).
team remove sgpbenchdio
team add sgpbenchdio
team modify sgpbenchdio collisionRule never
$scoreboard players set #diorama_lobby_last sgp.bench $(first)
$scoreboard players add #diorama_lobby_last sgp.bench $(lobby)
scoreboard players remove #diorama_lobby_last sgp.bench 1
$scoreboard players set #diorama_lobby_first sgp.bench $(first)
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] if score @s sgp.bench <= #diorama_lobby_last sgp.bench run function sgp.bench:scenarios/systems/diorama_ingame/place_lobby

$item replace entity @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] weapon.mainhand with diamond_sword[enchantments={sharpness:3},custom_data={sgp_bench_diorama:1b}]
$item replace entity @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] weapon.offhand with shield[custom_data={sgp_bench_diorama:1b}]
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] run function sgp.diorama:player_initialization
scoreboard players set #mannequin_update_time sgp.dummy 0
scoreboard players set #diorama_enabled sgp.dummy 1
scoreboard players set #mannequins_swing_enabled sgp.dummy 1
function sgp.diorama:tick/main
