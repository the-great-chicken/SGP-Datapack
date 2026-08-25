#> sgp.kits:stats_collector/elo/init
#
# Initialize report-facing metadata and restore always-on Elo runtime state.
# Reloading the datapack must never reset existing ratings.

# Only values consumed by extraction/reporting belong here. Formula and event
# rules remain implementation details in the functions that enforce them.
data modify storage sgp.kits:stats elo_metadata set value {initial_rating:1000.0d,metrics:{rating:{name:"Elo rating",description:"Current player-level Elo rating.",stored_unit:"centi_elo",display_unit:"elo",display_scale:0.01d},rated_encounters:{name:"Rated encounters",description:"Number of rated kill/death encounters involving the player.",stored_unit:"count",display_unit:"encounters",display_scale:1.0d}}}

execute unless data storage sgp.kits:stats elo_ratings run data modify storage sgp.kits:stats elo_ratings set value {}

function sgp.kits:stats_collector/elo/init_lookup

# No pending transaction or temporary selector tag may survive a reload.
scoreboard players set @a sgp.elo_pending 0
scoreboard players add @a sgp.elo_deaths_seen 0
tag @a remove sgp.elo_victim
tag @a remove sgp.elo_touched

execute as @a[tag=sgp.in_game] run function sgp.kits:stats_collector/elo/ensure_player
