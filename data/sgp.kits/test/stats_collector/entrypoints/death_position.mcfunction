#> sgp.kits:stats_collector/entrypoints/death_position
# @dummy
# @environment sgp.ci:stats_collector
#
# The real death-position entrypoint reads entity coordinates, floors tenths consistently (including negatives), and accumulates identical buckets.

assert entity @s[nbt={Dimension:"minecraft:overworld"}]
tp @s 123.41 80.01 -45.61
function sgp.kits:stats_collector/death_position/capture
tp @s 123.49 80.09 -45.69
function sgp.kits:stats_collector/death_position/capture
tp @s 123.50 80.125 -45.625
function sgp.kits:stats_collector/death_position/capture

execute store result storage sgp.ci:stats entry_position.same_bucket int 1 run data get storage sgp.kits:stats death_positions."minecraft:overworld"."1234,800,-457"
execute store result storage sgp.ci:stats entry_position.neighbor int 1 run data get storage sgp.kits:stats death_positions."minecraft:overworld"."1235,801,-457"
assert data storage sgp.ci:stats entry_position{same_bucket:2,neighbor:1}
assert not data storage sgp:macro stats.current_death_position
