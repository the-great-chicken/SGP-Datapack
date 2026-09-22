#> sgp.world:lieu/tick
#
# Per-tick location membership for every registered `lieu` marker
# (minecraft:execute_repeating_functions). A dedicated loop with eight rotating shards keeps
# each macro function's argument set within Minecraft's 8-entry macro cache, so a map with up
# to 64 locations pays no per-tick command re-parsing; the generic sgp.misc:loop_as_entity
# loop re-parsed two macro functions per marker every tick and serialized each marker's NBT
# twice. Marker data comes from the registry snapshot taken by lieu/register.
data modify storage sgp:data temp.lieu.list set from storage sgp:data markers_lists.location
execute if data storage sgp:data temp.lieu.list[0] run function sgp.world:lieu/loop/0 with storage sgp:data temp.lieu.list[0]
