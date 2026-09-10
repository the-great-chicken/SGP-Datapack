#> sgp.ci:diorama_spawns/fixture
# Seed map/model coordinates and two production spawn destinations for UI reconstruction.

scoreboard players set #map_96003_x sgp.dummy 32000
scoreboard players set #map_96003_y sgp.dummy 80000
scoreboard players set #map_96003_z sgp.dummy 32000
scoreboard players set #model_96003_x sgp.dummy 8000
scoreboard players set #model_96003_y sgp.dummy 80000
scoreboard players set #model_96003_z sgp.dummy 8000
summon marker 8.0 80.0 8.0 {Tags:["sgp.ci.menu"],data:{id:96003,mdx:7,mdy:7,mdz:7}}
data modify storage sgp:data spawns append value {id:96003,list:[{x:48.0,y:80.0,z:48.0,yaw:90.0,pitch:0.0,article:"au",title:{text:"First"},icon:"A"},{x:80.0,y:80.0,z:80.0,yaw:-90.0,pitch:15.0,article:"au",title:{text:"Second"},icon:"B"}]}
