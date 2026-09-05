#> sgp.misc:uuid_zero
#
# A zero UUID keeps all 32 digits and creates the requested destination list.

data remove storage sgp:data tests.uuid_zero
data modify storage sgp:data temp.obj set value {}
summon marker ~ ~ ~ {UUID:[I;0,0,0,0],Tags:["sgp.test.uuid_zero"]}

execute as @e[tag=sgp.test.uuid_zero,distance=..1,limit=1,type=marker] run function sgp.misc:uuid_array_to_string/init {list_location:"tests.uuid_zero"}
kill @e[tag=sgp.test.uuid_zero,distance=..1,type=marker]
data remove storage sgp:data temp.obj

data modify storage sgp:data tests.uuid_zero_result set value {}
data modify storage sgp:data tests.uuid_zero_result set from storage sgp:data tests.uuid_zero[0]
assert data storage sgp:data tests.uuid_zero_result{uuid:"00000000-0000-0000-0000-000000000000"}
assert not data storage sgp:data tests.uuid_zero[1]

data remove storage sgp:data tests.uuid_zero
data remove storage sgp:data tests.uuid_zero_result
