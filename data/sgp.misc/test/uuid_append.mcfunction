#> sgp.misc:uuid_append
#
# Consecutive conversions append distinct UUIDs, preserve existing entries, and retain caller-provided object fields.

data modify storage sgp:data tests.uuid_append set value [{uuid:"existing",id:99}]
data modify storage sgp:data temp.obj set value {id:1}
summon marker ~ ~ ~ {UUID:[I;1,2,3,4],Tags:["sgp.test.uuid_append_first"]}

execute as @e[tag=sgp.test.uuid_append_first,distance=..1,limit=1,type=marker] run function sgp.misc:uuid_array_to_string/init {list_location:"tests.uuid_append"}
kill @e[tag=sgp.test.uuid_append_first,distance=..1,type=marker]

data modify storage sgp:data temp.obj.id set value 2
summon marker ~ ~ ~ {UUID:[I;5,6,7,8],Tags:["sgp.test.uuid_append_second"]}

execute as @e[tag=sgp.test.uuid_append_second,distance=..1,limit=1,type=marker] run function sgp.misc:uuid_array_to_string/init {list_location:"tests.uuid_append"}
kill @e[tag=sgp.test.uuid_append_second,distance=..1,type=marker]
data remove storage sgp:data temp.obj

data modify storage sgp:data tests.uuid_append_result set value {}
data modify storage sgp:data tests.uuid_append_result.existing set from storage sgp:data tests.uuid_append[0]
data modify storage sgp:data tests.uuid_append_result.first set from storage sgp:data tests.uuid_append[1]
data modify storage sgp:data tests.uuid_append_result.second set from storage sgp:data tests.uuid_append[2]

assert data storage sgp:data tests.uuid_append_result.existing{uuid:"existing",id:99}
assert data storage sgp:data tests.uuid_append_result.first{uuid:"00000001-0000-0002-0000-000300000004",id:1}
assert data storage sgp:data tests.uuid_append_result.second{uuid:"00000005-0000-0006-0000-000700000008",id:2}
assert not data storage sgp:data tests.uuid_append[3]

data remove storage sgp:data tests.uuid_append
data remove storage sgp:data tests.uuid_append_result
