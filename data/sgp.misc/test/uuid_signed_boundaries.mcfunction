#> sgp.misc:uuid_signed_boundaries
#
# Convert signed 32-bit boundaries without losing their high bit or carrying sign state between integers.

data modify storage sgp:data tests.uuid_signed_boundaries set value []
data modify storage sgp:data temp.obj set value {}
summon marker ~ ~ ~ {UUID:[I;-2147483648,2147483647,-1,-2147483647],Tags:["sgp.test.uuid_signed_boundaries"]}

execute as @e[tag=sgp.test.uuid_signed_boundaries,distance=..1,limit=1,type=marker] run function sgp.misc:uuid_array_to_string/init {list_location:"tests.uuid_signed_boundaries"}
kill @e[tag=sgp.test.uuid_signed_boundaries,distance=..1,type=marker]
data remove storage sgp:data temp.obj

data modify storage sgp:data tests.uuid_signed_boundaries_result set value {}
data modify storage sgp:data tests.uuid_signed_boundaries_result set from storage sgp:data tests.uuid_signed_boundaries[0]
assert data storage sgp:data tests.uuid_signed_boundaries_result{uuid:"80000000-7fff-ffff-ffff-ffff80000001"}
assert not data storage sgp:data tests.uuid_signed_boundaries[1]

data remove storage sgp:data tests.uuid_signed_boundaries
data remove storage sgp:data tests.uuid_signed_boundaries_result
