#> sgp.misc:loop_as_entity/consecutive
#
# Consecutive calls use their own list and command, including per-entity execute conditions.

data modify storage sgp:data tests.loop_consecutive set value {first_list:[{uuid:"00000068-0000-0000-0000-000000000001"}],second_list:[{uuid:"00000068-0000-0000-0000-000000000001"},{uuid:"00000068-0000-0000-0000-000000000002"}]}
summon marker ~ ~ ~ {UUID:[I;104,0,0,1],Tags:["sgp.test.loop_consecutive","sgp.test.loop_consecutive_first"],data:{first:0,second:0}}
summon marker ~ ~ ~ {UUID:[I;104,0,0,2],Tags:["sgp.test.loop_consecutive","sgp.test.loop_consecutive_second"],data:{first:0,second:0}}

function sgp.misc:loop_as_entity/init {list_location:"tests.loop_consecutive.first_list",command:"run data modify entity @s data.first set value 1"}
function sgp.misc:loop_as_entity/init {list_location:"tests.loop_consecutive.second_list",command:"if entity @s[tag=sgp.test.loop_consecutive_second] run data modify entity @s data.second set value 1"}
data modify storage sgp:data tests.loop_consecutive.first set from entity @e[tag=sgp.test.loop_consecutive_first,distance=..1,limit=1,type=marker] data
data modify storage sgp:data tests.loop_consecutive.second set from entity @e[tag=sgp.test.loop_consecutive_second,distance=..1,limit=1,type=marker] data
kill @e[tag=sgp.test.loop_consecutive,distance=..1,type=marker]

assert data storage sgp:data tests.loop_consecutive.first{first:1,second:0}
assert data storage sgp:data tests.loop_consecutive.second{first:0,second:1}

data remove storage sgp:data tests.loop_consecutive
