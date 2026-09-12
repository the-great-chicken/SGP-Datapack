#> sgp.diorama:mapping/giant_center_and_ramp
# @dummy
# @environment sgp.ci:diorama_mapping/giant_center_and_ramp

gamemode spectator @s
tp @s 8.0 88.0 8.0
function sgp.ci:diorama_mapping/ready
await entity @e[tag=sgp.ci.mapping_ready,x=8,y=88,z=8,distance=..1,type=marker]
function sgp.ci:diorama_mapping/giant_fixture
# The center has no outward displacement.
tp @s 9.0 80.0 8.5 0 0
execute at @s run function sgp.diorama:tick/update_mannequin/update_giant_pos {id:94001}
function sgp.ci:diorama_mapping/expect {group:giant,x:"32.0",y:"80.0",z:"24.0"}
# Halfway to either edge adds half the eight-block pushback.
tp @s 9.5 80.5 8.25 90 25
execute at @s run function sgp.diorama:tick/update_mannequin/update_giant_pos {id:94001}
function sgp.ci:diorama_mapping/expect {group:giant,x:"44.0",y:"88.0",z:"16.0"}
execute store result score #ci.mapping.yaw sgp.dummy run data get entity @n[tag=sgp.ci.mapping_giant,type=mannequin] Rotation[0] 1000
execute store result score #ci.mapping.pitch sgp.dummy run data get entity @n[tag=sgp.ci.mapping_giant,type=mannequin] Rotation[1] 1000
assert score #ci.mapping.yaw sgp.dummy matches 90000
assert score #ci.mapping.pitch sgp.dummy matches 25000
tp @s 8.5 79.5 8.75 0 0
execute at @s run function sgp.diorama:tick/update_mannequin/update_giant_pos {id:94001}
function sgp.ci:diorama_mapping/expect {group:giant,x:"20.0",y:"72.0",z:"32.0"}
