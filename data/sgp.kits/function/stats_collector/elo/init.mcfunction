#> sgp.kits:stats_collector/elo/init
#
# Initialize static metadata and restore always-on Elo runtime state.
# Reloading the datapack must never reset existing ratings.

data modify storage sgp.kits:stats elo_metadata set value {name:"Kill Elo",description:"Zero-sum player rating updated from credited PvP kills outside major events.",algorithm:"elo_logistic",initial_rating:1000.0d,k_factor:10.0d,rating_divisor:400.0d,result_type:"credited_pvp_kill",major_events_rated:0b,environmental_deaths_rated:0b,self_kills_rated:0b,update_mode:"same_tick_batch",metrics:{rating:{name:"Elo rating",description:"Current player-level Kill Elo rating.",stored_unit:"centi_elo",display_unit:"elo",display_scale:0.01d},rated_encounters:{name:"Rated encounters",description:"Number of valid Elo kill or death results involving the player.",stored_unit:"count",display_unit:"encounters",display_scale:1.0d}}}

execute unless data storage sgp.kits:stats elo_ratings run data modify storage sgp.kits:stats elo_ratings set value {}

function sgp.kits:stats_collector/elo/init_lookup

# No pending transaction or temporary selector tag may survive a reload.
scoreboard players set @a sgp.elo_pending 0
scoreboard players add @a sgp.elo_deaths_seen 0
tag @a remove sgp.elo_victim
tag @a remove sgp.elo_touched

execute as @a[tag=sgp.in_game] run function sgp.kits:stats_collector/elo/ensure_player
