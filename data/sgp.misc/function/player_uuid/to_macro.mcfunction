#> sgp.misc:player_uuid/to_macro
#
# Copy the executing player's UUID into storage sgp:macro owner.uuid.
# Reading `UUID` straight from a player entity serializes the whole player (~40 µs per read),
# so the value is cached per sgp.id in storage and only read from the entity once.

execute store result storage sgp:macro owner.id int 1 run scoreboard players get @s sgp.id
execute if score @s sgp.id matches 1.. run return run function sgp.misc:player_uuid/load with storage sgp:macro owner
data modify storage sgp:macro owner.uuid set from entity @s UUID
