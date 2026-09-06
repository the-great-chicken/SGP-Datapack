#> sgp.misc:summon_multiple/count_and_data
#
# A first call creates exactly the requested entities, with their NBT and spawn position.

# Reproduce a fresh installation, before the helper has ever run.
scoreboard players reset #summon_nbr sgp.dummy
execute positioned ~0.5 ~1 ~0.5 run function sgp.misc:summon_multiple {nbr:10,entity:marker,nbt:{Tags:["sgp.test.summon_count"],data:{label:"bat group",duration:7}},execute:'return 0'}
execute positioned ~0.5 ~1 ~0.5 store result storage sgp:data tests.summon_count.correct int 1 if entity @e[tag=sgp.test.summon_count,nbt={data:{label:"bat group",duration:7}},distance=..0.01,type=marker]
execute store result storage sgp:data tests.summon_count.total int 1 run kill @e[tag=sgp.test.summon_count,distance=..2,type=marker]

assert data storage sgp:data tests.summon_count{correct:10,total:10}
data remove storage sgp:data tests.summon_count
