#> sgp.kits:ability_entrypoints/bigger
# @dummy
# @environment sgp.ci:ability_entrypoints/bigger
#
# Tank routing must initialize timers and apply the complete temporary attribute boost.

function sgp.ci:ability_entrypoints/seed_stats {id:920002,kit:5,ability:"bigger"}
tag @s add sgp.tank
gamemode survival @s
function sgp.ci:bigger/expect {scale:"99999..100001",jump:"41999..42001",reach:"299999..300001",damage:"99999..100001"}

execute at @s run function sgp.kits:abilities/route_ability

function sgp.ci:ability_entrypoints/expect_timers {ability:"bigger"}
assert entity @s[tag=sgp.stats_tank_boost_active]
function sgp.ci:bigger/expect {scale:"199999..200001",jump:"52499..52501",reach:"449999..450001",damage:"199999..200001"}

function sgp.kits:abilities/bigger/end
assert not entity @s[tag=sgp.stats_tank_boost_active]
function sgp.ci:bigger/expect {scale:"99999..100001",jump:"41999..42001",reach:"299999..300001",damage:"99999..100001"}
