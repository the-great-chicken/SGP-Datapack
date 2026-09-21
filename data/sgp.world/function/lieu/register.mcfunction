#> sgp.world:lieu/register
#
# Executed as a `lieu` marker (sgp.world:initialization): append it to the per-tick registry
# together with a snapshot of its data. The per-tick loop reads the snapshot instead of
# serializing the marker's NBT twice per tick, so marker data edited in place only applies
# once sgp.world:initialization runs again (a reload), which is how map makers already work.
function sgp.misc:uuid_array_to_string/init {list_location:"sgp:data markers_lists.location"}
data modify storage sgp:data markers_lists.location[-1].data set from entity @s data
