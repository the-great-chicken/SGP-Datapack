#> sgp.misc:loop_as_entity/context
#
# Each command runs as its listed entity and at that entity's position.

data modify storage sgp:data tests.loop_context set value {list:[{uuid:"00000066-0000-0000-0000-000000000001"},{uuid:"00000066-0000-0000-0000-000000000002"}]}
summon marker ~0.25 ~ ~ {UUID:[I;102,0,0,1],Tags:["sgp.test.loop_context","sgp.test.loop_context_first"]}
summon marker ~0.75 ~ ~ {UUID:[I;102,0,0,2],Tags:["sgp.test.loop_context","sgp.test.loop_context_second"]}

function sgp.misc:loop_as_entity/init {list_location:"tests.loop_context.list",command:"run tp @s ~0.125 ~ ~"}
execute positioned ~0.375 ~ ~ store success storage sgp:data tests.loop_context.first byte 1 if entity @e[tag=sgp.test.loop_context_first,distance=..0.01,type=marker]
execute positioned ~0.875 ~ ~ store success storage sgp:data tests.loop_context.second byte 1 if entity @e[tag=sgp.test.loop_context_second,distance=..0.01,type=marker]
kill @e[tag=sgp.test.loop_context,distance=..2,type=marker]

assert data storage sgp:data tests.loop_context{first:1b,second:1b}

data remove storage sgp:data tests.loop_context
