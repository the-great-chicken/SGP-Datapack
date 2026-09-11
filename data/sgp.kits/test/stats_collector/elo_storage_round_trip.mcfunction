#> sgp.kits:stats_collector/elo_storage_round_trip
# @dummy
# @environment sgp.ci:stats_collector
#
# Missing Elo records start at the configured rating, while existing records restore rating/experience exactly and clear pending transfers.

scoreboard players set @s sgp.elo 1
scoreboard players set @s sgp.elo_encounters 99
scoreboard players set @s sgp.elo_pending 77
function sgp.kits:stats_collector/elo/ensure_player_storage {id:910010}

assert score @s sgp.elo matches 100000
assert score @s sgp.elo_encounters matches 0
assert score @s sgp.elo_pending matches 0
assert data storage sgp.kits:stats elo_ratings.910010{rating:100000,rated_encounters:0}

data modify storage sgp.kits:stats elo_ratings.910011 set value {rating:123456,rated_encounters:29}
scoreboard players set @s sgp.elo 5
scoreboard players set @s sgp.elo_encounters 6
scoreboard players set @s sgp.elo_pending -700
function sgp.kits:stats_collector/elo/ensure_player_storage {id:910011}

assert score @s sgp.elo matches 123456
assert score @s sgp.elo_encounters matches 29
assert score @s sgp.elo_pending matches 0
assert data storage sgp.kits:stats elo_ratings.910011{rating:123456,rated_encounters:29}
