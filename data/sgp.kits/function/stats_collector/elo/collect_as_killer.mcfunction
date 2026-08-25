#> sgp.kits:stats_collector/elo/collect_as_killer
#
# Executed as the credited killer while sgp.elo_victim identifies the victim.
# Ratings are not changed here: only same-tick pending transfers are accumulated.

function sgp.kits:stats_collector/elo/ensure_player

# Round the signed centi-Elo difference to the nearest whole Elo point.
scoreboard players operation #elo_difference sgp.dummy = @s sgp.elo
scoreboard players operation #elo_difference sgp.dummy -= @a[tag=sgp.elo_victim,limit=1] sgp.elo
scoreboard players set #elo_difference_negative sgp.dummy 0
execute if score #elo_difference sgp.dummy matches ..-1 run scoreboard players set #elo_difference_negative sgp.dummy 1
execute if score #elo_difference_negative sgp.dummy matches 1 run scoreboard players operation #elo_difference sgp.dummy *= -1 sgp.dummy
scoreboard players add #elo_difference sgp.dummy 50
scoreboard players operation #elo_difference sgp.dummy /= 100 sgp.dummy
execute if score #elo_difference_negative sgp.dummy matches 1 run scoreboard players operation #elo_difference sgp.dummy *= -1 sgp.dummy

# At these extremes the K=10 result already rounds to 10.00 or 0.00.
execute if score #elo_difference sgp.dummy matches ..-1322 run scoreboard players set #elo_difference sgp.dummy -1321
execute if score #elo_difference sgp.dummy matches 1322.. run scoreboard players set #elo_difference sgp.dummy 1321

scoreboard players operation #elo_lookup_index sgp.dummy = #elo_difference sgp.dummy
scoreboard players add #elo_lookup_index sgp.dummy 1321
execute store result storage sgp:macro stats.elo_lookup.index int 1 \
    run scoreboard players get #elo_lookup_index sgp.dummy
scoreboard players set #elo_delta sgp.dummy 0
function sgp.kits:stats_collector/elo/read_delta with storage sgp:macro stats.elo_lookup

# One zero-sum transfer; both ratings are applied after every death is collected.
scoreboard players operation @s sgp.elo_pending += #elo_delta sgp.dummy
scoreboard players operation @a[tag=sgp.elo_victim,limit=1] sgp.elo_pending -= #elo_delta sgp.dummy
scoreboard players add @s sgp.elo_encounters 1
scoreboard players add @a[tag=sgp.elo_victim,limit=1] sgp.elo_encounters 1
tag @s add sgp.elo_touched
tag @a[tag=sgp.elo_victim,limit=1] add sgp.elo_touched
