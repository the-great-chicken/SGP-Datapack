#> sgp.kits:stats_collector/elo_apply_pending
# @dummy
# @environment sgp.ci:stats_collector_guarded
#
# Applying a pending transfer is atomic, persists the final rating, and exposes the rounded sidebar only from encounter 30 onward.

scoreboard players set @s sgp.id 910012
scoreboard players set @s sgp.elo 100000
scoreboard players set @s sgp.elo_pending 2500
scoreboard players set @s sgp.elo_encounters 29
scoreboard players set @s sgp.elo_display 777
tag @s add sgp.elo_touched
function sgp.kits:stats_collector/elo/apply_pending

execute store result storage sgp.ci:stats elo_apply.first_rating int 1 run scoreboard players get @s sgp.elo
execute store result storage sgp.ci:stats elo_apply.first_pending int 1 run scoreboard players get @s sgp.elo_pending
execute store result storage sgp.ci:stats elo_apply.first_encounters int 1 run scoreboard players get @s sgp.elo_encounters
scoreboard players set #ci.stats.has_display sgp.dummy 0
execute if score @s sgp.elo_display = @s sgp.elo_display run scoreboard players set #ci.stats.has_display sgp.dummy 1
execute store result storage sgp.ci:stats elo_apply.first_has_display int 1 run scoreboard players get #ci.stats.has_display sgp.dummy
execute store result storage sgp.ci:stats elo_apply.first_saved_rating int 1 run data get storage sgp.kits:stats elo_ratings.910012.rating
execute store result storage sgp.ci:stats elo_apply.first_saved_encounters int 1 run data get storage sgp.kits:stats elo_ratings.910012.rated_encounters

scoreboard players set @s sgp.elo_pending -500
scoreboard players set @s sgp.elo_encounters 30
tag @s add sgp.elo_touched
function sgp.kits:stats_collector/elo/apply_pending

execute store result storage sgp.ci:stats elo_apply.second_rating int 1 run scoreboard players get @s sgp.elo
execute store result storage sgp.ci:stats elo_apply.second_pending int 1 run scoreboard players get @s sgp.elo_pending
execute store result storage sgp.ci:stats elo_apply.second_display int 1 run scoreboard players get @s sgp.elo_display
execute store result storage sgp.ci:stats elo_apply.second_saved_rating int 1 run data get storage sgp.kits:stats elo_ratings.910012.rating
execute store result storage sgp.ci:stats elo_apply.second_saved_encounters int 1 run data get storage sgp.kits:stats elo_ratings.910012.rated_encounters
scoreboard players reset #ci.stats.has_display sgp.dummy

function sgp.ci:stats_collector/restore_runtime_globals

assert data storage sgp.ci:stats elo_apply{first_rating:102500,first_pending:0,first_encounters:29,first_has_display:0,first_saved_rating:102500,first_saved_encounters:29,second_rating:102000,second_pending:0,second_display:1020,second_saved_rating:102000,second_saved_encounters:30}
assert not entity @s[tag=sgp.elo_touched]
assert data storage sgp.kits:stats elo_ratings.910012{rating:102000,rated_encounters:30}
