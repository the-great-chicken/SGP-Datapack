#> sgp.misc:summon_multiple/callback_context
#
# Each callback sees the supplied NBT and runs once as the new entity, not the caller or an existing entity.

summon marker ~ ~ ~ {Tags:["sgp.test.summon_callback_source"]}
summon marker ~0.5 ~ ~ {Tags:["sgp.test.summon_callback"],data:{ready:1b}}
scoreboard players set @e[tag=sgp.test.summon_callback,distance=..2,type=marker] sgp.dummy 0
execute as @e[tag=sgp.test.summon_callback_source,distance=..2,limit=1,type=marker] run function sgp.misc:summon_multiple {nbr:3,entity:marker,nbt:{Tags:["sgp.test.summon_callback"],data:{ready:1b}},execute:'execute if data entity @s data{ready:1b} run scoreboard players add @s sgp.dummy 1'}
execute store result storage sgp:data tests.summon_callback.called int 1 if entity @e[tag=sgp.test.summon_callback,scores={sgp.dummy=1},distance=..2,type=marker]
execute store result storage sgp:data tests.summon_callback.untouched int 1 if entity @e[tag=sgp.test.summon_callback,scores={sgp.dummy=0},distance=..2,type=marker]
execute store success storage sgp:data tests.summon_callback.caller_changed byte 1 if entity @e[tag=sgp.test.summon_callback_source,scores={sgp.dummy=1..},distance=..2,type=marker]
kill @e[tag=sgp.test.summon_callback,distance=..2,type=marker]
kill @e[tag=sgp.test.summon_callback_source,distance=..2,type=marker]

assert data storage sgp:data tests.summon_callback{called:3,untouched:1,caller_changed:0b}
data remove storage sgp:data tests.summon_callback
