#> sgp.misc:loop_as_entity/order
#
# Visit entries in order, including duplicates, without modifying the source list or visiting unlisted entities.

data modify storage sgp.ci:loop_as_entity order set value {list:[{uuid:"00000065-0000-0000-0000-000000000001",id:10},{uuid:"00000065-0000-0000-0000-000000000002",id:20},{uuid:"00000065-0000-0000-0000-000000000001",id:30}],visits:[]}
data modify storage sgp.ci:loop_as_entity order.before set from storage sgp.ci:loop_as_entity order.list
summon marker ~ ~ ~ {UUID:[I;101,0,0,1],Tags:["sgp.test.loop_order"],data:{id:1}}
summon marker ~ ~ ~ {UUID:[I;101,0,0,2],Tags:["sgp.test.loop_order"],data:{id:2}}
summon marker ~ ~ ~ {UUID:[I;101,0,0,3],Tags:["sgp.test.loop_order"],data:{id:3}}

function sgp.misc:loop_as_entity/init {list_location:"sgp.ci:loop_as_entity order.list",command:"run data modify storage sgp.ci:loop_as_entity order.visits append from entity @s data.id"}
kill @e[tag=sgp.test.loop_order,distance=..1,type=marker]

# Setting an identical value reports no change; list comparison preserves order and length.
execute store success storage sgp.ci:loop_as_entity order.visits_changed byte 1 run data modify storage sgp.ci:loop_as_entity order.visits set value [1,2,1]
execute store success storage sgp.ci:loop_as_entity order.source_changed byte 1 run data modify storage sgp.ci:loop_as_entity order.list set from storage sgp.ci:loop_as_entity order.before
assert data storage sgp.ci:loop_as_entity order{visits_changed:0b,source_changed:0b}

data remove storage sgp.ci:loop_as_entity order
