#> sgp.kits:stats_collector/death_position_buckets
# @dummy
# @environment sgp.ci:stats_collector
#
# Death-position counters accumulate exact quantized coordinates and keep dimensions and neighboring buckets separate.

function sgp.kits:stats_collector/death_position/save {dimension:"sgp.ci:test_dimension",x:123,y:640,z:-456}
function sgp.kits:stats_collector/death_position/save {dimension:"sgp.ci:test_dimension",x:123,y:640,z:-456}
function sgp.kits:stats_collector/death_position/save {dimension:"sgp.ci:test_dimension",x:124,y:640,z:-456}
function sgp.kits:stats_collector/death_position/save {dimension:"minecraft:the_nether",x:123,y:640,z:-456}

execute store result storage sgp.ci:stats positions.primary int 1 run data get storage sgp.kits:stats death_positions."sgp.ci:test_dimension"."123,640,-456"
execute store result storage sgp.ci:stats positions.neighbor int 1 run data get storage sgp.kits:stats death_positions."sgp.ci:test_dimension"."124,640,-456"
execute store result storage sgp.ci:stats positions.nether int 1 run data get storage sgp.kits:stats death_positions."minecraft:the_nether"."123,640,-456"

assert data storage sgp.ci:stats positions{primary:2,neighbor:1,nether:1}
