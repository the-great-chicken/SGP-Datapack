#> sgp.misc:uuid_array_to_string/zero
#
# A zero UUID keeps all 32 digits and creates the requested destination list.

data remove storage sgp.ci:uuid_array_to_string zero.output
data modify storage sgp:data temp.obj set value {}
summon marker ~ ~ ~ {UUID:[I;0,0,0,0],Tags:["sgp.test.uuid_zero"]}

execute as @e[tag=sgp.test.uuid_zero,distance=..1,limit=1,type=marker] run function sgp.misc:uuid_array_to_string/init {list_location:"sgp.ci:uuid_array_to_string zero.output"}
kill @e[tag=sgp.test.uuid_zero,distance=..1,type=marker]
data remove storage sgp:data temp.obj

data modify storage sgp.ci:uuid_array_to_string zero.actual set value {}
data modify storage sgp.ci:uuid_array_to_string zero.actual set from storage sgp.ci:uuid_array_to_string zero.output[0]
assert data storage sgp.ci:uuid_array_to_string zero.actual{uuid:"00000000-0000-0000-0000-000000000000"}
assert not data storage sgp.ci:uuid_array_to_string zero.output[1]

data remove storage sgp.ci:uuid_array_to_string zero.output
data remove storage sgp.ci:uuid_array_to_string zero.actual
