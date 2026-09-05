#> sgp.kits:stats_collector/elo/collect_as_killer
#
# Executed as the credited killer while sgp.elo_victim identifies the victim.
# Ratings are not changed here: only same-tick pending transfers are accumulated.

function sgp.kits:stats_collector/elo/ensure_player

# Pick one shared K factor from the participants' average pre-fight experience.
# Using one value for both sides keeps every rating transfer exactly zero-sum.
scoreboard players operation #elo_average_encounters sgp.dummy = @s sgp.elo_encounters
scoreboard players operation #elo_average_encounters sgp.dummy += @a[tag=sgp.elo_victim,limit=1] sgp.elo_encounters
scoreboard players operation #elo_average_encounters sgp.dummy /= 2 sgp.dummy
scoreboard players set #elo_k_factor sgp.dummy 18
execute if score #elo_average_encounters sgp.dummy matches ..24 run scoreboard players set #elo_k_factor sgp.dummy 80
execute if score #elo_average_encounters sgp.dummy matches 25..74 run scoreboard players set #elo_k_factor sgp.dummy 50
execute if score #elo_average_encounters sgp.dummy matches 75..149 run scoreboard players set #elo_k_factor sgp.dummy 30

# Round the signed centi-Elo difference to the nearest whole Elo point, then
# use its absolute value as the lookup index.
scoreboard players operation #elo_difference sgp.dummy = @s sgp.elo
scoreboard players operation #elo_difference sgp.dummy -= @a[tag=sgp.elo_victim,limit=1] sgp.elo
scoreboard players set #elo_difference_negative sgp.dummy 0
execute if score #elo_difference sgp.dummy matches ..-1 run scoreboard players set #elo_difference_negative sgp.dummy 1
execute if score #elo_difference_negative sgp.dummy matches 1 run scoreboard players operation #elo_difference sgp.dummy *= -1 sgp.dummy
scoreboard players add #elo_difference sgp.dummy 50
scoreboard players operation #elo_difference sgp.dummy /= 100 sgp.dummy

# At this gap even K=80 rounds to either its full value or zero centi-Elo.
execute if score #elo_difference sgp.dummy matches 4416.. run scoreboard players set #elo_difference sgp.dummy 4415

scoreboard players operation #elo_lookup_index sgp.dummy = #elo_difference sgp.dummy
execute store result storage sgp:macro stats.elo_lookup.index int 1 \
    run scoreboard players get #elo_lookup_index sgp.dummy
execute store result storage sgp:macro stats.elo_lookup.k int 1 \
    run scoreboard players get #elo_k_factor sgp.dummy
function sgp.kits:stats_collector/elo/read_delta with storage sgp:macro stats.elo_lookup

# The lookup stores a favorite winner's transfer. Complement it to K when the
# killer is the underdog; all values are centi-Elo.
scoreboard players operation #elo_delta sgp.dummy = #elo_favorite_delta sgp.dummy
execute if score #elo_difference_negative sgp.dummy matches 1 run scoreboard players operation #elo_delta sgp.dummy = #elo_k_factor sgp.dummy
execute if score #elo_difference_negative sgp.dummy matches 1 run scoreboard players operation #elo_delta sgp.dummy *= 100 sgp.dummy
execute if score #elo_difference_negative sgp.dummy matches 1 run scoreboard players operation #elo_delta sgp.dummy -= #elo_favorite_delta sgp.dummy

# One zero-sum transfer; both ratings are applied after every death is collected.
scoreboard players operation @s sgp.elo_pending += #elo_delta sgp.dummy
scoreboard players operation @a[tag=sgp.elo_victim,limit=1] sgp.elo_pending -= #elo_delta sgp.dummy
scoreboard players add @s sgp.elo_encounters 1
scoreboard players add @a[tag=sgp.elo_victim,limit=1] sgp.elo_encounters 1
tag @s add sgp.elo_touched
tag @a[tag=sgp.elo_victim,limit=1] add sgp.elo_touched
