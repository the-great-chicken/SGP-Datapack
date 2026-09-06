#> sgp.ci:lootdrop/fixture
# Two chest locations and room for players to open and leave them.

fill ~-1 ~ ~-1 ~13 ~5 ~8 air
fill ~-1 ~ ~-1 ~13 ~ ~8 stone
summon marker ~2 ~1 ~2 {Tags:["sgp.marker","sgp.ci.lootdrop","sgp.ci.lootdrop.first"],CustomName:"Lootdrop",data:{facing:"north"}}
summon marker ~9 ~1 ~2 {Tags:["sgp.marker","sgp.ci.lootdrop","sgp.ci.lootdrop.second"],CustomName:"Lootdrop",data:{facing:"east"}}
summon marker ~6 ~1 ~6 {Tags:["sgp.marker","sgp.ci.lootdrop"],CustomName:"pvp_arena",data:{radius:40}}
execute as @e[tag=sgp.ci.lootdrop,name=Lootdrop,type=marker] run function sgp.misc:uuid_array_to_string/init {list_location:"markers_lists.lootdrop"}
setblock ~5 ~1 ~5 barrel
tp @s ~2.5 ~1 ~4.5
gamemode creative @s
tag @s add sgp.in_game
function sgp.mineurs:lootdrop/start
