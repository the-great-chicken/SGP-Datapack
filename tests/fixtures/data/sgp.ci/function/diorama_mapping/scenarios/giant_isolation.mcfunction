#> sgp.ci:diorama_mapping/scenarios/giant_isolation

function sgp.ci:diorama_mapping/giant_fixture
summon mannequin 10.0 80.0 10.0 {Tags:["sgp.ci.mapping","sgp.ci.mapping_giant_other_owner","sgp.giant_mannequin_94001"],NoGravity:true,Invulnerable:true,immovable:true}
scoreboard players set @e[tag=sgp.ci.mapping_giant_other_owner,type=mannequin] bs.link.to 94012
summon mannequin 12.0 80.0 12.0 {Tags:["sgp.ci.mapping","sgp.ci.mapping_giant_other_map","sgp.giant_mannequin_94002"],NoGravity:true,Invulnerable:true,immovable:true}
scoreboard players set @e[tag=sgp.ci.mapping_giant_other_map,type=mannequin] bs.link.to 94011
tp @s 9.5 80.5 8.25 0 0
execute at @s run function sgp.diorama:tick/update_mannequin/update_giant_pos {id:94001}
function sgp.ci:diorama_mapping/expect {group:giant,x:"44.0",y:"88.0",z:"16.0"}
function sgp.ci:diorama_mapping/expect {group:first,x:"8.0",y:"80.0",z:"8.0"}
function sgp.ci:diorama_mapping/expect {group:giant_other_owner,x:"10.0",y:"80.0",z:"10.0"}
function sgp.ci:diorama_mapping/expect {group:giant_other_map,x:"12.0",y:"80.0",z:"12.0"}
