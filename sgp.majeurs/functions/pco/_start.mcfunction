tellraw @a[x=2405,y=201,z=2133,dx=137,dy=54,dz=72] [{"text":"Lancement de Poule Canard Oie...","color":"dark_purple","bold":true}]
function sgp.mineurs:common/stop

statuswarp pvp disabled
useglow toggle
function sgp.majeurs:pco/dispatch

# Mets les cages dans l'arène
function sgp.majeurs:pco/canard/clone_cages
function sgp.majeurs:pco/poule/clone_cages
function sgp.majeurs:pco/oie/clone_cages

tp @e[team=Oie] 2502.5 239 2176.5
tp @e[team=Poule] 2485.5 244 2139.5
tp @e[team=Canard] 2530.5 248 2145.5
targetglow @a[team=Canard] @a[gamemode=survival,team=Canard] GREEN
targetglow @a[team=Canard] @a[gamemode=survival,team=Oie] YELLOW
targetglow @a[team=Oie] @a[gamemode=survival,team=Oie] YELLOW
targetglow @a[team=Oie] @a[gamemode=survival,team=Poule] RED
targetglow @a[team=Poule] @a[gamemode=survival,team=Poule] RED
targetglow @a[team=Poule] @a[gamemode=survival,team=Canard] GREEN
execute as @a[team=Oie] run function sgp.majeurs:pco/oie/kit
execute as @a[team=Poule] run function sgp.majeurs:pco/poule/kit
execute as @a[team=Canard] run function sgp.majeurs:pco/canard/kit
move @a[team=Oie] #Oies
move @a[team=Poule] #Poules
move @a[team=Canard] #Canards
scoreboard players set @a[team=Oie] liberer_oies 0
scoreboard players set @a[team=Canard] liberer_canards 0
scoreboard players set @a[team=Poule] liberer_poules 0

title @a[team=Oie] subtitle [{"text":"Chassez les ","color":"white","bold":true},{"text":"Poules","color":"red"}]
title @a[team=Oie] title {"text":"Oie","color":"yellow","bold":true}
tellraw @a[team=Oie] [{"text":"Vous êtes une ","color":"white"},{"text":"Oie. ","color":"yellow","bold":true},{"text":"Vous devez chasser les ","color":"white"},{"text":"Poules.","color":"red","bold":true}]
title @a[team=Poule] subtitle [{"text":"Chassez les ","color":"white","bold":true},{"text":"Canards","color":"green"}]
title @a[team=Poule] title {"text":"Poule","color":"red","bold":true}
tellraw @a[team=Poule] [{"text":"Vous êtes une ","color":"white"},{"text":"Poule. ","color":"red","bold":true},{"text":"Vous devez chasser les ","color":"white"},{"text":"Canards.","color":"green","bold":true}]
title @a[team=Canard] subtitle [{"text":"Chassez les ","color":"white","bold":true},{"text":"Oies","color":"yellow"}]
title @a[team=Canard] title {"text":"Canard","color":"green","bold":true}
tellraw @a[team=Canard] [{"text":"Vous êtes un ","color":"white"},{"text":"Canard. ","color":"green","bold":true},{"text":"Vous devez chasser les ","color":"white"},{"text":"Oies.","color":"yellow","bold":true}]

fill 2500 239 2182 2500 239 2180 minecraft:warped_fence_gate[facing=west]
fill 2499 239 2179 2497 239 2179 minecraft:warped_fence_gate[facing=south]
fill 2538 248 2144 2540 248 2144 minecraft:warped_fence_gate[facing=north]
fill 2537 248 2141 2537 248 2143 minecraft:warped_fence_gate[facing=west]
fill 2524 248 2144 2526 248 2144 minecraft:warped_fence_gate[facing=north]
setblock 2478 244 2141 minecraft:warped_fence_gate[facing=west]
setblock 2484 244 2141 minecraft:warped_fence_gate[facing=west]

scoreboard players set @a temps_cabane_pco 0
function sgp.lore:npcs/disable