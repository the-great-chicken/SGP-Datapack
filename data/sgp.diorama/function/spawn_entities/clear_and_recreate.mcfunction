#> sgp.diorama:spawn_entities/clear_and_recreate
#
# Remove interaction entities present in the model, and create new updated ones

function sgp.diorama:spawn_entities/clear_volume with entity @s data

data remove storage sgp:data temp.spawns_list
$data modify storage sgp:data temp.spawns_list set from storage sgp:data spawns[{id:$(id)}].list
$function sgp.diorama:spawn_entities/create_loop {id:$(id)}