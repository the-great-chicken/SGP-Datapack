#> sgp.bench:scenarios/events/minor_event/lootdrop/setup
# `{first, last, players, event}`
# Four production Lootdrop markers on the floor between actor rows, registered like
# sgp.mineurs:initialization does; the event summons two of them.
kill @e[tag=sgp.bench.lootdrop,type=marker]
summon marker -13 81 -10 {CustomName:"Lootdrop",Tags:["sgp.marker","sgp.bench.lootdrop"],data:{facing:"north"}}
summon marker 8 81 -10 {CustomName:"Lootdrop",Tags:["sgp.marker","sgp.bench.lootdrop"],data:{facing:"north"}}
summon marker -13 81 11 {CustomName:"Lootdrop",Tags:["sgp.marker","sgp.bench.lootdrop"],data:{facing:"north"}}
summon marker 8 81 11 {CustomName:"Lootdrop",Tags:["sgp.marker","sgp.bench.lootdrop"],data:{facing:"north"}}
data remove storage sgp:data markers_lists.lootdrop
execute as @e[tag=sgp.marker,name="Lootdrop",type=marker] run function sgp.misc:uuid_array_to_string/init {list_location:"sgp:data markers_lists.lootdrop"}
function sgp.mineurs:lootdrop/start
# The open-chest close detection cannot be simulated: PackTest dummies never open a container,
# so the chest reads as closed at once and the schedule chain multiplies. Not measured here.
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)},limit=2] run tag @s add sgp.bench.sharer
