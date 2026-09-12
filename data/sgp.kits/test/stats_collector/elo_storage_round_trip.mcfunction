#> sgp.kits:stats_collector/elo_storage_round_trip
# @dummy
# @environment sgp.ci:stats_collector
#
# Missing Elo records start at the configured rating, while existing records restore rating/experience exactly and clear pending transfers.
# ensure_player_storage is normally invoked with sgp:macro stats.current_elo_player; mirror that private-helper contract here.

scoreboard players set @s sgp.elo 1
scoreboard players set @s sgp.elo_encounters 99
scoreboard players set @s sgp.elo_pending 77
data modify storage sgp:macro stats.current_elo_player set value {id:910010}
function sgp.kits:stats_collector/elo/ensure_player_storage with storage sgp:macro stats.current_elo_player

assert score @s sgp.elo matches 100000
assert score @s sgp.elo_encounters matches 0
assert score @s sgp.elo_pending matches 0
assert data storage sgp.kits:stats elo_ratings.910010{rating:100000,rated_encounters:0}

data modify storage sgp.kits:stats elo_ratings.910011 set value {rating:123456,rated_encounters:29}
scoreboard players set @s sgp.elo 5
scoreboard players set @s sgp.elo_encounters 6
scoreboard players set @s sgp.elo_pending -700
data modify storage sgp:macro stats.current_elo_player set value {id:910011}
function sgp.kits:stats_collector/elo/ensure_player_storage with storage sgp:macro stats.current_elo_player

assert score @s sgp.elo matches 123456
assert score @s sgp.elo_encounters matches 29
assert score @s sgp.elo_pending matches 0
assert data storage sgp.kits:stats elo_ratings.910011{rating:123456,rated_encounters:29}
