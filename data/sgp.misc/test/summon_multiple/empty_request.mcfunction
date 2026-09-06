#> sgp.misc:summon_multiple/empty_request
#
# A zero-sized request creates nothing, skips its callback, and leaves the next request usable.

data modify storage sgp:data tests.summon_empty set value {callback_ran:0b}
function sgp.misc:summon_multiple {nbr:0,entity:marker,nbt:{Tags:["sgp.test.summon_empty"]},execute:'data modify storage sgp:data tests.summon_empty.callback_ran set value 1b'}
execute store result storage sgp:data tests.summon_empty.count int 1 if entity @e[tag=sgp.test.summon_empty,distance=..2,type=marker]
function sgp.misc:summon_multiple {nbr:2,entity:marker,nbt:{Tags:["sgp.test.summon_after_empty"]},execute:'return 0'}
execute store result storage sgp:data tests.summon_empty.next_count int 1 run kill @e[tag=sgp.test.summon_after_empty,distance=..2,type=marker]
kill @e[tag=sgp.test.summon_empty,distance=..2,type=marker]

assert data storage sgp:data tests.summon_empty{callback_ran:0b,count:0,next_count:2}
data remove storage sgp:data tests.summon_empty
