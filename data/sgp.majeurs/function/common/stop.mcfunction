#> sgp.majeurs:common/stop
# 
# Things that get executed at the end of every major event

gamemode survival @a[tag=sgp.in_game]
scoreboard players set @a[tag=sgp.in_game] sgp.death_reset_tags 1
scoreboard players set @a[tag=sgp.in_game] sgp.streak_en_cours 0
removeglow @a
team leave @a
statuswarp pvp enabled
function sgp.lore:npcs/enable
experience set @a[tag=sgp.in_game] 0 levels
useglow toggle