#> sgp.misc:uuid_array_to_string/hex_digits
#
# Preserve integer order, leading zeroes, lowercase hex digits, and UUID hyphens.

data modify storage sgp:data tests.uuid_hex_digits set value []
data modify storage sgp:data temp.obj set value {}
summon marker ~ ~ ~ {UUID:[I;19088743,-1985229329,-19088744,1985229328],Tags:["sgp.test.uuid_hex_digits"]}

execute as @e[tag=sgp.test.uuid_hex_digits,distance=..1,limit=1,type=marker] run function sgp.misc:uuid_array_to_string/init {list_location:"tests.uuid_hex_digits"}
kill @e[tag=sgp.test.uuid_hex_digits,distance=..1,type=marker]
data remove storage sgp:data temp.obj

data modify storage sgp:data tests.uuid_hex_digits_result set value {}
data modify storage sgp:data tests.uuid_hex_digits_result set from storage sgp:data tests.uuid_hex_digits[0]
assert data storage sgp:data tests.uuid_hex_digits_result{uuid:"01234567-89ab-cdef-fedc-ba9876543210"}
assert not data storage sgp:data tests.uuid_hex_digits[1]

data remove storage sgp:data tests.uuid_hex_digits
data remove storage sgp:data tests.uuid_hex_digits_result
