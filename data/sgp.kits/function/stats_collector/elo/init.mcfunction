#> sgp.kits:stats_collector/elo/init
#
# Initialize report-facing metadata and restore always-on Elo runtime state.
# Reloading the datapack must never reset existing ratings.

# Authoritative configuration for extraction and reporting. `k_factor` is the
# initial/maximum value; the full shared tier schedule is recorded separately.
data modify storage sgp.kits:stats elo_metadata set value {initial_rating:1000.0d,k_factor:80.0d,k_factor_schedule:[{minimum_average_encounters:0,k_factor:80.0d},{minimum_average_encounters:25,k_factor:50.0d},{minimum_average_encounters:75,k_factor:30.0d},{minimum_average_encounters:150,k_factor:18.0d}],rating_divisor:1050.0d,metrics:{rating:{name:"Elo rating",description:"Current player-level Elo rating.",stored_unit:"centi_elo",display_unit:"elo",display_scale:0.01d},rated_encounters:{name:"Rated encounters",description:"Number of rated kill/death encounters involving the player.",stored_unit:"count",display_unit:"encounters",display_scale:1.0d}}}

execute unless data storage sgp.kits:stats elo_ratings run data modify storage sgp.kits:stats elo_ratings set value {}

function sgp.kits:stats_collector/elo/init_lookup

# No pending transaction or temporary selector tag may survive a reload.
scoreboard players set @a sgp.elo_pending 0
tag @a remove sgp.elo_victim
tag @a remove sgp.elo_touched

execute as @a[tag=sgp.in_game] run function sgp.kits:stats_collector/elo/ensure_player
