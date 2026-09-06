#> sgp.misc:summon_multiple/consecutive_calls
#
# Consecutive requests use their own count, entity type, and callback, even when the previous callback returns failure.

function sgp.misc:summon_multiple {nbr:3,entity:marker,nbt:{Tags:["sgp.test.summon_first"]},execute:'return fail'}
function sgp.misc:summon_multiple {nbr:1,entity:armor_stand,nbt:{Tags:["sgp.test.summon_second"],Marker:1b,Invisible:1b},execute:'tag @s add sgp.test.summon_second_ready'}
execute store result storage sgp:data tests.summon_consecutive.first int 1 run kill @e[tag=sgp.test.summon_first,distance=..2,type=marker]
execute store result storage sgp:data tests.summon_consecutive.ready int 1 if entity @e[tag=sgp.test.summon_second,tag=sgp.test.summon_second_ready,distance=..2,type=armor_stand]
execute store result storage sgp:data tests.summon_consecutive.second int 1 run kill @e[tag=sgp.test.summon_second,distance=..2,type=armor_stand]

assert data storage sgp:data tests.summon_consecutive{first:3,ready:1,second:1}
data remove storage sgp:data tests.summon_consecutive
