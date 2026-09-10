#> sgp.diorama:mapping/giant_edge_limit
# @dummy
# @environment sgp.ci:diorama_mapping/giant_edge_limit

gamemode spectator @s
tp @s 8.0 88.0 8.0
function sgp.ci:diorama_mapping/ready
await entity @e[tag=sgp.ci.mapping_ready,x=8,y=88,z=8,distance=..1,type=marker]
function sgp.ci:diorama_mapping/giant_fixture
# The outward offset reaches eight blocks at the map edge.
tp @s 10.0 80.0 9.0 0 0
execute at @s run function sgp.diorama:tick/update_mannequin/update_giant_pos {id:94001}
function sgp.ci:diorama_mapping/expect {group:giant,x:"56.0",y:"80.0",z:"40.0"}
# Beyond the edge, player motion still maps normally but the extra offset stops growing.
tp @s 10.5 80.0 9.5 0 0
execute at @s run function sgp.diorama:tick/update_mannequin/update_giant_pos {id:94001}
function sgp.ci:diorama_mapping/expect {group:giant,x:"64.0",y:"80.0",z:"48.0"}
tp @s 8.0 80.0 8.0 0 0
execute at @s run function sgp.diorama:tick/update_mannequin/update_giant_pos {id:94001}
function sgp.ci:diorama_mapping/expect {group:giant,x:"8.0",y:"80.0",z:"8.0"}
tp @s 7.5 80.0 7.5 0 0
execute at @s run function sgp.diorama:tick/update_mannequin/update_giant_pos {id:94001}
function sgp.ci:diorama_mapping/expect {group:giant,x:"0.0",y:"80.0",z:"0.0"}
