#> sgp.majeurs:common/stop
# 
# Things that get executed at the end of every major event

scoreboard players set @a[tag=sgp.in_game] sgp.death_reset_tags 1
scoreboard players set @a[tag=sgp.in_game] sgp.streak_en_cours 0
removeglow @a[tag=sgp.in_game]
execute as @a[tag=sgp.in_game,team=!] run team leave @s
statuswarp pvp enabled
function sgp.lore:npcs/enable
experience set @a[tag=sgp.in_game] 0 levels
gamemode survival @a[tag=sgp.in_game]
useglow toggle