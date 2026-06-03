#> sgp.misc:diorama/tick

tag @a remove sgp.around_model

function sgp.misc:loop_as_entity/init {list_location:"markers_lists.playable_map", command:"run function sgp.misc:diorama/tick_small with entity @s data"}
function sgp.misc:loop_as_entity/init {list_location:"markers_lists.playable_map_model", command:"run function sgp.misc:diorama/tick_giant with entity @s data"}