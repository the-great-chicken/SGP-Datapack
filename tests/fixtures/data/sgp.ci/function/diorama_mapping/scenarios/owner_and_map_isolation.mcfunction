#> sgp.ci:diorama_mapping/scenarios/owner_and_map_isolation

function sgp.ci:diorama_mapping/fixture
scoreboard players set #map_94002_x sgp.dummy 0
scoreboard players set #map_94002_y sgp.dummy 80000
scoreboard players set #map_94002_z sgp.dummy 0
scoreboard players set #model_94002_x sgp.dummy 12000
scoreboard players set #model_94002_y sgp.dummy 80000
scoreboard players set #model_94002_z sgp.dummy 12000
summon mannequin 12 80 12 {Tags:["sgp.ci.mapping","sgp.ci.mapping_other_map","sgp.small_mannequin_94002"],NoGravity:true,Invulnerable:true,immovable:true}
scoreboard players set @e[tag=sgp.ci.mapping_other_map,type=mannequin] bs.link.to 94011
summon mannequin 10 80 10 {Tags:["sgp.ci.mapping","sgp.ci.mapping_other_owner","sgp.small_mannequin_94001"],NoGravity:true,Invulnerable:true,immovable:true}
scoreboard players set @e[tag=sgp.ci.mapping_other_owner,type=mannequin] bs.link.to 94012
tp @s 32 88 8 0 0
execute at @s run function sgp.diorama:tick/update_mannequin/update_small_pos {id:94001}
function sgp.ci:diorama_mapping/expect {group:first,x:9,y:80.5,z:7.5}
function sgp.ci:diorama_mapping/expect {group:other_map,x:12,y:80,z:12}
function sgp.ci:diorama_mapping/expect {group:other_owner,x:10,y:80,z:10}
execute at @s run function sgp.diorama:tick/update_mannequin/update_small_pos {id:94002}
function sgp.ci:diorama_mapping/expect {group:other_map,x:14,y:80.5,z:12.5}
function sgp.ci:diorama_mapping/expect {group:first,x:9,y:80.5,z:7.5}
function sgp.ci:diorama_mapping/expect {group:other_owner,x:10,y:80,z:10}
