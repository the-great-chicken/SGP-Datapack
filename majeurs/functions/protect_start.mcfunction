execute in minecraft:minisjeux_crea run tellraw @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72] [{"text":"Lancement de l'event Proteger le Roi...", "color":"gold", "bold":true}]
execute in minecraft:minisjeux_crea as @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72] run function world:on_death
execute in minecraft:minisjeux_crea run function majeurs:protect_dispatch
fill 2537 253 2203 2537 251 2193 minecraft:barrier replace air
function mineurs:stop
scoreboard players enable @a[x=2414,y=251,z=2161,dx=3,dy=3,dz=3] devenirroirouge
title @a[x=2414,y=251,z=2161,dx=3,dy=3,dz=3] title [{"text":"Équipe Rouge", "color":"dark_red"}]
scoreboard players enable @a[x=2410,y=251,z=2161,dx=3,dy=3,dz=3] devenirroibleu
title @a[x=2410,y=251,z=2161,dx=3,dy=3,dz=3] title [{"text":"Équipe Bleu", "color":"dark_blue"}]
setblock 2480 230 2166 minecraft:prismarine_brick_slab[type=bottom]
statuswarp pvp disabled
move @a[x=2410,y=251,z=2161,dx=3,dy=3,dz=3] #Bleus
move @a[x=2414,y=251,z=2161,dx=3,dy=3,dz=3] #Rouges
sudo Bafy78 useglow toggle