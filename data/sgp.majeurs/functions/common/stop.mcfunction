#> sgp.majeurs:common/stop
# 
# Things that get executed at the end of every major event

scoreboard players set @a[tag=in_game] sgp.death_reset_tags 1
scoreboard players set @a[tag=in_game] sgp.streak_en_cours 0
team leave @a
statuswarp pvp enabled
removeglow @a
function sgp.lore:enable_npcs
experience set @a[tag=in_game] 0 levels
gamemode survival @a[tag=in_game]
useglow
