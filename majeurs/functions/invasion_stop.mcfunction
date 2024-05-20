scoreboard players set #invasion nbr_de_joueurs 0
experience set @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72] 0 levels
statuswarp pvp enabled
scoreboard players set @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72] death_reset_tags 1
team empty Attaquant
team empty Defenseur
scoreboard players set @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72] streak_en_cours 0
removeglow @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72]
sudo Bafy78 useglow toggle
gamemode survival @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72]
scoreboard players set #invasion_secondes timer_second 0
scoreboard players set #invasion_ticks timer_second 0
useglow
fill 2495 253 2164 2495 244 2164 minecraft:weeping_vines_plant
function lore:enable_npcs