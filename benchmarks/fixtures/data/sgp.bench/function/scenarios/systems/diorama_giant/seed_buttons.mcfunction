#> sgp.bench:scenarios/systems/diorama_giant/seed_buttons
# `{buttons: 0..16}`
#
# Seed a deliberately busy but bounded model UI. The 4x4 spawn grid maps from
# the 64x64 playable-map coordinates into distinct points inside the 4x4 model.
# Keeping the list in normal sgp:data storage lets the production Diorama
# spawn/hover code build and cache the interactions exactly as it does in-game.

data remove storage sgp:data spawns[{id:99001}]
data modify storage sgp:data spawns append value {id:99001,list:[]}
$scoreboard players set #diorama_buttons sgp.bench $(buttons)

execute if score #diorama_buttons sgp.bench matches 1.. run data modify storage sgp:data spawns[{id:99001}].list append value {x:24.0d,y:161.0d,z:24.0d,yaw:0.0f,pitch:0.0f,article:"au",title:{text:"Bench 01"},icon:"1"}
execute if score #diorama_buttons sgp.bench matches 2.. run data modify storage sgp:data spawns[{id:99001}].list append value {x:32.0d,y:161.0d,z:24.0d,yaw:0.0f,pitch:0.0f,article:"au",title:{text:"Bench 02"},icon:"2"}
execute if score #diorama_buttons sgp.bench matches 3.. run data modify storage sgp:data spawns[{id:99001}].list append value {x:40.0d,y:161.0d,z:24.0d,yaw:0.0f,pitch:0.0f,article:"au",title:{text:"Bench 03"},icon:"3"}
execute if score #diorama_buttons sgp.bench matches 4.. run data modify storage sgp:data spawns[{id:99001}].list append value {x:48.0d,y:161.0d,z:24.0d,yaw:0.0f,pitch:0.0f,article:"au",title:{text:"Bench 04"},icon:"4"}
execute if score #diorama_buttons sgp.bench matches 5.. run data modify storage sgp:data spawns[{id:99001}].list append value {x:24.0d,y:161.0d,z:32.0d,yaw:0.0f,pitch:0.0f,article:"au",title:{text:"Bench 05"},icon:"5"}
execute if score #diorama_buttons sgp.bench matches 6.. run data modify storage sgp:data spawns[{id:99001}].list append value {x:32.0d,y:161.0d,z:32.0d,yaw:0.0f,pitch:0.0f,article:"au",title:{text:"Bench 06"},icon:"6"}
execute if score #diorama_buttons sgp.bench matches 7.. run data modify storage sgp:data spawns[{id:99001}].list append value {x:40.0d,y:161.0d,z:32.0d,yaw:0.0f,pitch:0.0f,article:"au",title:{text:"Bench 07"},icon:"7"}
execute if score #diorama_buttons sgp.bench matches 8.. run data modify storage sgp:data spawns[{id:99001}].list append value {x:48.0d,y:161.0d,z:32.0d,yaw:0.0f,pitch:0.0f,article:"au",title:{text:"Bench 08"},icon:"8"}
execute if score #diorama_buttons sgp.bench matches 9.. run data modify storage sgp:data spawns[{id:99001}].list append value {x:24.0d,y:161.0d,z:40.0d,yaw:0.0f,pitch:0.0f,article:"au",title:{text:"Bench 09"},icon:"9"}
execute if score #diorama_buttons sgp.bench matches 10.. run data modify storage sgp:data spawns[{id:99001}].list append value {x:32.0d,y:161.0d,z:40.0d,yaw:0.0f,pitch:0.0f,article:"au",title:{text:"Bench 10"},icon:"A"}
execute if score #diorama_buttons sgp.bench matches 11.. run data modify storage sgp:data spawns[{id:99001}].list append value {x:40.0d,y:161.0d,z:40.0d,yaw:0.0f,pitch:0.0f,article:"au",title:{text:"Bench 11"},icon:"B"}
execute if score #diorama_buttons sgp.bench matches 12.. run data modify storage sgp:data spawns[{id:99001}].list append value {x:48.0d,y:161.0d,z:40.0d,yaw:0.0f,pitch:0.0f,article:"au",title:{text:"Bench 12"},icon:"C"}
execute if score #diorama_buttons sgp.bench matches 13.. run data modify storage sgp:data spawns[{id:99001}].list append value {x:24.0d,y:161.0d,z:48.0d,yaw:0.0f,pitch:0.0f,article:"au",title:{text:"Bench 13"},icon:"D"}
execute if score #diorama_buttons sgp.bench matches 14.. run data modify storage sgp:data spawns[{id:99001}].list append value {x:32.0d,y:161.0d,z:48.0d,yaw:0.0f,pitch:0.0f,article:"au",title:{text:"Bench 14"},icon:"E"}
execute if score #diorama_buttons sgp.bench matches 15.. run data modify storage sgp:data spawns[{id:99001}].list append value {x:40.0d,y:161.0d,z:48.0d,yaw:0.0f,pitch:0.0f,article:"au",title:{text:"Bench 15"},icon:"F"}
execute if score #diorama_buttons sgp.bench matches 16.. run data modify storage sgp:data spawns[{id:99001}].list append value {x:48.0d,y:161.0d,z:48.0d,yaw:0.0f,pitch:0.0f,article:"au",title:{text:"Bench 16"},icon:"G"}
