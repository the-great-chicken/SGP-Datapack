#> sgp.misc:loop_as_entity/missing_entity
#
# An absent entity in the middle of the list does not stop later entries from running.

data modify storage sgp:data tests.loop_missing_entity set value {list:[{uuid:"00000067-0000-0000-0000-000000000001"},{uuid:"00000067-0000-0000-0000-000000000003"},{uuid:"00000067-0000-0000-0000-000000000002"}],visits:[]}
summon marker ~ ~ ~ {UUID:[I;103,0,0,1],Tags:["sgp.test.loop_missing_entity"],data:{id:1}}
summon marker ~ ~ ~ {UUID:[I;103,0,0,2],Tags:["sgp.test.loop_missing_entity"],data:{id:2}}

function sgp.misc:loop_as_entity/init {list_location:"tests.loop_missing_entity.list",command:"run data modify storage sgp:data tests.loop_missing_entity.visits append from entity @s data.id"}
kill @e[tag=sgp.test.loop_missing_entity,distance=..1,type=marker]

execute store success storage sgp:data tests.loop_missing_entity.visits_changed byte 1 run data modify storage sgp:data tests.loop_missing_entity.visits set value [1,2]
assert data storage sgp:data tests.loop_missing_entity{visits_changed:0b}

data remove storage sgp:data tests.loop_missing_entity
