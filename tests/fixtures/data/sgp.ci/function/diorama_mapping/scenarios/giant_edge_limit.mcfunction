#> sgp.ci:diorama_mapping/scenarios/giant_edge_limit

function sgp.ci:diorama_mapping/giant_fixture
# The outward offset reaches eight blocks at the map edge.
tp @s 10 80 9 0 0
execute at @s run function sgp.diorama:tick/update_mannequin/update_giant_pos {id:94001}
function sgp.ci:diorama_mapping/expect {group:giant,x:56,y:80,z:40}
# Beyond the edge, player motion still maps normally but the extra offset stops growing.
tp @s 10.5 80 9.5 0 0
execute at @s run function sgp.diorama:tick/update_mannequin/update_giant_pos {id:94001}
function sgp.ci:diorama_mapping/expect {group:giant,x:64,y:80,z:48}
tp @s 8 80 8 0 0
execute at @s run function sgp.diorama:tick/update_mannequin/update_giant_pos {id:94001}
function sgp.ci:diorama_mapping/expect {group:giant,x:8,y:80,z:8}
tp @s 7.5 80 7.5 0 0
execute at @s run function sgp.diorama:tick/update_mannequin/update_giant_pos {id:94001}
function sgp.ci:diorama_mapping/expect {group:giant,x:0,y:80,z:0}
