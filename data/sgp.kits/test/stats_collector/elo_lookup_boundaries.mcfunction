#> sgp.kits:stats_collector/elo_lookup_boundaries
# @dummy
# @environment sgp.ci:stats_collector
#
# The precomputed Elo table has the expected 50/50 transfers for every K tier and reaches zero at the capped extreme gap.

function sgp.kits:stats_collector/elo/read_delta {index:0,k:80}
execute store result storage sgp.ci:stats elo_lookup.k80_equal int 1 run scoreboard players get #elo_favorite_delta sgp.dummy
function sgp.kits:stats_collector/elo/read_delta {index:0,k:50}
execute store result storage sgp.ci:stats elo_lookup.k50_equal int 1 run scoreboard players get #elo_favorite_delta sgp.dummy
function sgp.kits:stats_collector/elo/read_delta {index:0,k:30}
execute store result storage sgp.ci:stats elo_lookup.k30_equal int 1 run scoreboard players get #elo_favorite_delta sgp.dummy
function sgp.kits:stats_collector/elo/read_delta {index:0,k:18}
execute store result storage sgp.ci:stats elo_lookup.k18_equal int 1 run scoreboard players get #elo_favorite_delta sgp.dummy
function sgp.kits:stats_collector/elo/read_delta {index:4414,k:80}
execute store result storage sgp.ci:stats elo_lookup.k80_penultimate int 1 run scoreboard players get #elo_favorite_delta sgp.dummy
function sgp.kits:stats_collector/elo/read_delta {index:4415,k:80}
execute store result storage sgp.ci:stats elo_lookup.k80_last int 1 run scoreboard players get #elo_favorite_delta sgp.dummy

assert data storage sgp.ci:stats elo_lookup{k80_equal:4000,k50_equal:2500,k30_equal:1500,k18_equal:900,k80_penultimate:1,k80_last:0}
