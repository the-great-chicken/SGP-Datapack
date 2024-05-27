#> sgp.majeurs:common/stop
# 
# Things that get executed at the end of every major event

scoreboard players set @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72] sgp.death_reset_tags 1
scoreboard players set @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72] sgp.streak_en_cours 0
team leave @a
statuswarp pvp enabled
removeglow @a
function sgp.lore:enable_npcs
experience set @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72] 0 levels
gamemode survival @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72]
useglow
