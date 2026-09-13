#> sgp.misc:uuid_array_to_string/append
#
# Consecutive conversions append distinct UUIDs, preserve existing entries, and retain caller-provided object fields.

data modify storage sgp.ci:uuid_array_to_string append.output set value [{uuid:"existing",id:99}]
data modify storage sgp:data temp.obj set value {id:1}
summon marker ~ ~ ~ {UUID:[I;1,2,3,4],Tags:["sgp.test.uuid_append_first"]}

execute as @e[tag=sgp.test.uuid_append_first,distance=..1,limit=1,type=marker] run function sgp.misc:uuid_array_to_string/init {list_location:"sgp.ci:uuid_array_to_string append.output"}
kill @e[tag=sgp.test.uuid_append_first,distance=..1,type=marker]

data modify storage sgp:data temp.obj.id set value 2
summon marker ~ ~ ~ {UUID:[I;5,6,7,8],Tags:["sgp.test.uuid_append_second"]}

execute as @e[tag=sgp.test.uuid_append_second,distance=..1,limit=1,type=marker] run function sgp.misc:uuid_array_to_string/init {list_location:"sgp.ci:uuid_array_to_string append.output"}
kill @e[tag=sgp.test.uuid_append_second,distance=..1,type=marker]
data remove storage sgp:data temp.obj

data modify storage sgp.ci:uuid_array_to_string append.actual set value {}
data modify storage sgp.ci:uuid_array_to_string append.actual.existing set from storage sgp.ci:uuid_array_to_string append.output[0]
data modify storage sgp.ci:uuid_array_to_string append.actual.first set from storage sgp.ci:uuid_array_to_string append.output[1]
data modify storage sgp.ci:uuid_array_to_string append.actual.second set from storage sgp.ci:uuid_array_to_string append.output[2]

assert data storage sgp.ci:uuid_array_to_string append.actual.existing{uuid:"existing",id:99}
assert data storage sgp.ci:uuid_array_to_string append.actual.first{uuid:"00000001-0000-0002-0000-000300000004",id:1}
assert data storage sgp.ci:uuid_array_to_string append.actual.second{uuid:"00000005-0000-0006-0000-000700000008",id:2}
assert not data storage sgp.ci:uuid_array_to_string append.output[3]

data remove storage sgp.ci:uuid_array_to_string append.output
data remove storage sgp.ci:uuid_array_to_string append.actual
