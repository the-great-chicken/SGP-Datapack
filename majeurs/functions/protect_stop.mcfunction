tp @a[x=2405,y=201,z=2133,dx=137,dy=57,dz=72] 2422 251.5 2136 0 0
clear @a[x=2405,y=201,z=2133,dx=137,dy=57,dz=72]
effect clear @a[x=2405,y=201,z=2133,dx=137,dy=57,dz=72]
team empty bleue
team empty rouge
tag @a remove roirouge
tag @a remove roibleu
execute as @a run trigger devenirroibleu set 0
execute as @a run trigger devenirroirouge set 0
fill 2537 253 2203 2537 251 2193 minecraft:air
scoreboard players set #mort_roi_rouge_annoncee test 0
scoreboard players set #mort_roi_bleu_annoncee test 0
setblock 2480 230 2166 air replace
scoreboard players set @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72] streak_en_cours 0
statuswarp pvp enabled
removeglow @a
sudo Bafy78 useglow toggle
gamemode survival @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72]