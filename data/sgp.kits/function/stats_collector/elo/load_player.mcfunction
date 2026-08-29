#> sgp.kits:stats_collector/elo/load_player
# `{id: player id}`

$execute store result score @s sgp.elo run data get storage sgp.kits:stats elo_ratings.$(id).rating
$execute store result score @s sgp.elo_encounters run data get storage sgp.kits:stats elo_ratings.$(id).rated_encounters
scoreboard players set @s sgp.elo_pending 0
