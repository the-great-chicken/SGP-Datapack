#> sgp.diorama:mapping/position_and_facing
# @dummy
# @environment sgp.ci:diorama_mapping/position_and_facing

gamemode spectator @s
tp @s 8.0 88.0 8.0
function sgp.ci:diorama_mapping/ready
await entity @e[tag=sgp.ci.mapping_ready,x=8,y=88,z=8,distance=..1,type=marker]
function sgp.ci:diorama_mapping/fixture
tp @s 16.0 80.0 16.0 0 0
execute at @s run function sgp.diorama:tick/update_mannequin/update_small_pos {id:94001}
function sgp.ci:diorama_mapping/expect {group:first,x:"8.0",y:"80.0",z:"8.0"}
# Offsets in all three axes are scaled relative to the map origin.
tp @s 32.0 88.0 8.0 90 25
execute at @s run function sgp.diorama:tick/update_mannequin/update_small_pos {id:94001}
function sgp.ci:diorama_mapping/expect {group:first,x:"9.0",y:"80.5",z:"7.5"}
execute store result score #ci.mapping.yaw sgp.dummy run data get entity @n[tag=sgp.ci.mapping_first,type=mannequin] Rotation[0] 1000
execute store result score #ci.mapping.pitch sgp.dummy run data get entity @n[tag=sgp.ci.mapping_first,type=mannequin] Rotation[1] 1000
assert score #ci.mapping.yaw sgp.dummy matches 90000
assert score #ci.mapping.pitch sgp.dummy matches 25000
tp @s 8.0 76.0 24.0 0 0
execute at @s run function sgp.diorama:tick/update_mannequin/update_small_pos {id:94001}
function sgp.ci:diorama_mapping/expect {group:first,x:"7.5",y:"79.75",z:"8.5"}
