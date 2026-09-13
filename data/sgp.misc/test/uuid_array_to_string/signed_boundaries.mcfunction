#> sgp.misc:uuid_array_to_string/signed_boundaries
#
# Convert signed 32-bit boundaries without losing their high bit or carrying sign state between integers.

data modify storage sgp.ci:uuid_array_to_string signed_boundaries.output set value []
data modify storage sgp:data temp.obj set value {}
summon marker ~ ~ ~ {UUID:[I;-2147483648,2147483647,-1,-2147483647],Tags:["sgp.test.uuid_signed_boundaries"]}

execute as @e[tag=sgp.test.uuid_signed_boundaries,distance=..1,limit=1,type=marker] run function sgp.misc:uuid_array_to_string/init {list_location:"sgp.ci:uuid_array_to_string signed_boundaries.output"}
kill @e[tag=sgp.test.uuid_signed_boundaries,distance=..1,type=marker]
data remove storage sgp:data temp.obj

data modify storage sgp.ci:uuid_array_to_string signed_boundaries.actual set value {}
data modify storage sgp.ci:uuid_array_to_string signed_boundaries.actual set from storage sgp.ci:uuid_array_to_string signed_boundaries.output[0]
assert data storage sgp.ci:uuid_array_to_string signed_boundaries.actual{uuid:"80000000-7fff-ffff-ffff-ffff80000001"}
assert not data storage sgp.ci:uuid_array_to_string signed_boundaries.output[1]

data remove storage sgp.ci:uuid_array_to_string signed_boundaries.output
data remove storage sgp.ci:uuid_array_to_string signed_boundaries.actual
