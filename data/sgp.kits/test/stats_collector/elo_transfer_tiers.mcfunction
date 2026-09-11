#> sgp.kits:stats_collector/elo_transfer_tiers
# @dummy
# @environment sgp.ci:stats_collector_guarded
#
# Rated encounters are zero-sum, use the shared K tier from average experience, and complement the favorite transfer for an underdog win.

scoreboard players set #stats_schema_version sgp.dummy 7
scoreboard players set #stats_paused sgp.dummy 0
scoreboard players set @s sgp.id 910014
scoreboard players set @s sgp.elo 100000
scoreboard players set @s sgp.elo_pending 0
tag @s add sgp.in_game

dummy StatsVictim spawn
scoreboard players set StatsVictim sgp.id 910015
scoreboard players set StatsVictim sgp.elo 100000
scoreboard players set StatsVictim sgp.elo_pending 0
tag StatsVictim add sgp.in_game
tag StatsVictim add sgp.elo_victim

# Average encounters 0 -> K=80 -> equal-rating transfer 40.00 Elo.
scoreboard players set @s sgp.elo_encounters 0
scoreboard players set StatsVictim sgp.elo_encounters 0
function sgp.kits:stats_collector/elo/collect_as_killer
execute store result storage sgp.ci:stats elo_transfer.k80_winner int 1 run scoreboard players get @s sgp.elo_pending
execute store result storage sgp.ci:stats elo_transfer.k80_loser int 1 run scoreboard players get StatsVictim sgp.elo_pending
execute store result storage sgp.ci:stats elo_transfer.k80_winner_encounters int 1 run scoreboard players get @s sgp.elo_encounters
execute store result storage sgp.ci:stats elo_transfer.k80_loser_encounters int 1 run scoreboard players get StatsVictim sgp.elo_encounters

# Average encounters 25 -> K=50.
scoreboard players set @s sgp.elo_pending 0
scoreboard players set StatsVictim sgp.elo_pending 0
scoreboard players set @s sgp.elo_encounters 25
scoreboard players set StatsVictim sgp.elo_encounters 25
function sgp.kits:stats_collector/elo/collect_as_killer
execute store result storage sgp.ci:stats elo_transfer.k50 int 1 run scoreboard players get @s sgp.elo_pending

# Average encounters 75 -> K=30.
scoreboard players set @s sgp.elo_pending 0
scoreboard players set StatsVictim sgp.elo_pending 0
scoreboard players set @s sgp.elo_encounters 75
scoreboard players set StatsVictim sgp.elo_encounters 75
function sgp.kits:stats_collector/elo/collect_as_killer
execute store result storage sgp.ci:stats elo_transfer.k30 int 1 run scoreboard players get @s sgp.elo_pending

# Average encounters 150 -> K=18.
scoreboard players set @s sgp.elo_pending 0
scoreboard players set StatsVictim sgp.elo_pending 0
scoreboard players set @s sgp.elo_encounters 150
scoreboard players set StatsVictim sgp.elo_encounters 150
function sgp.kits:stats_collector/elo/collect_as_killer
execute store result storage sgp.ci:stats elo_transfer.k18 int 1 run scoreboard players get @s sgp.elo_pending

# A 200-Elo underdog win at K=18 complements the favorite's 7.06 Elo transfer to 10.94.
scoreboard players set @s sgp.elo 90000
scoreboard players set StatsVictim sgp.elo 110000
scoreboard players set @s sgp.elo_pending 0
scoreboard players set StatsVictim sgp.elo_pending 0
scoreboard players set @s sgp.elo_encounters 150
scoreboard players set StatsVictim sgp.elo_encounters 150
function sgp.kits:stats_collector/elo/collect_as_killer
execute store result storage sgp.ci:stats elo_transfer.underdog_winner int 1 run scoreboard players get @s sgp.elo_pending
execute store result storage sgp.ci:stats elo_transfer.underdog_loser int 1 run scoreboard players get StatsVictim sgp.elo_pending

# Reverse the ratings: the favorite gets the table value itself.
scoreboard players set @s sgp.elo 110000
scoreboard players set StatsVictim sgp.elo 90000
scoreboard players set @s sgp.elo_pending 0
scoreboard players set StatsVictim sgp.elo_pending 0
scoreboard players set @s sgp.elo_encounters 150
scoreboard players set StatsVictim sgp.elo_encounters 150
function sgp.kits:stats_collector/elo/collect_as_killer
execute store result storage sgp.ci:stats elo_transfer.favorite_winner int 1 run scoreboard players get @s sgp.elo_pending
execute store result storage sgp.ci:stats elo_transfer.favorite_loser int 1 run scoreboard players get StatsVictim sgp.elo_pending

dummy StatsVictim leave
tag @s remove sgp.in_game
tag @s remove sgp.elo_touched
function sgp.ci:stats_collector/restore_runtime_globals

assert data storage sgp.ci:stats elo_transfer{k80_winner:4000,k80_loser:-4000,k80_winner_encounters:1,k80_loser_encounters:1,k50:2500,k30:1500,k18:900,underdog_winner:1094,underdog_loser:-1094,favorite_winner:706,favorite_loser:-706}
