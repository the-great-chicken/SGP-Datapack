#> sgp.misc:loop_as_entity/empty
#
# Empty and absent lists execute no command, including after a completed loop.

data modify storage sgp:data tests.loop_empty set value {list:[],called:0}
function sgp.misc:loop_as_entity/init {list_location:"tests.loop_empty.list",command:"run data modify storage sgp:data tests.loop_empty.called set value 1"}
assert data storage sgp:data tests.loop_empty{called:0}
assert not data storage sgp:data tests.loop_empty.list[0]

summon marker ~ ~ ~ {UUID:[I;100,0,0,1],Tags:["sgp.test.loop_empty"]}
data modify storage sgp:data tests.loop_empty.list set value [{uuid:"00000064-0000-0000-0000-000000000001"}]
function sgp.misc:loop_as_entity/init {list_location:"tests.loop_empty.list",command:"run data modify storage sgp:data tests.loop_empty.called set value 1"}
kill @e[tag=sgp.test.loop_empty,distance=..1,type=marker]
assert data storage sgp:data tests.loop_empty{called:1}

function sgp.misc:loop_as_entity/init {list_location:"tests.loop_empty.absent",command:"run data modify storage sgp:data tests.loop_empty.called set value 2"}
assert data storage sgp:data tests.loop_empty{called:1}
assert not data storage sgp:data tests.loop_empty.absent

data remove storage sgp:data tests.loop_empty
