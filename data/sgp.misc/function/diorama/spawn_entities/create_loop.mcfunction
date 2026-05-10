#> sgp.misc:diorama/spawn_entities/create_loop
#
# Create the interaction entities for spawns in the diorama

# Stop the loop if the list is empty
execute unless data storage sgp:data temp.spawns_list[0] run return 0

execute summon interaction run function sgp.misc:diorama/spawn_entities/summon

# Remove the processed element from the list and loop again
data remove storage sgp:data temp.spawns_list[0]
function sgp.misc:diorama/spawn_entities/create_loop