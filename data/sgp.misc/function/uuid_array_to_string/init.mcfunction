#> sgp.misc:uuid_array_to_string/init
# `{list_location: nbt path}`
#
# Convert the UUID array of the entity into its string version, and store it

# Reset the string and global digit counter
data modify storage sgp:data temp.string set value ""
scoreboard players set #global_digit_index sgp.dummy 0

# Process the 4 integers from right to left (int3 -> int2 -> int1 -> int0)
execute store result score #current sgp.dummy run data get entity @s UUID[3]
function sgp.misc:uuid_array_to_string/process_int

execute store result score #current sgp.dummy run data get entity @s UUID[2]
function sgp.misc:uuid_array_to_string/process_int

execute store result score #current sgp.dummy run data get entity @s UUID[1]
function sgp.misc:uuid_array_to_string/process_int

execute store result score #current sgp.dummy run data get entity @s UUID[0]
function sgp.misc:uuid_array_to_string/process_int

data modify storage sgp:data temp.obj.uuid set from storage sgp:data temp.string

# Store the finished string at the specified location
$data modify storage sgp:data $(list_location) append from storage sgp:data temp.obj