tellraw @a[tag=in_game] [{"text":"Lancement de Poule Canard Oie...","color":"dark_purple","bold":true}]
function sgp.mineurs:common/stop

statuswarp pvp disabled
useglow toggle
function sgp.majeurs:pco/dispatch

# Mets les cages dans l'arène
function sgp.majeurs:pco/canard/clone_cages
function sgp.majeurs:pco/poule/clone_cages
function sgp.majeurs:pco/oie/clone_cages

tp @e[team=sgp.Oie] 2502.5 239 2176.5
tp @e[team=sgp.Poule] 2485.5 244 2139.5
tp @e[team=sgp.Canard] 2530.5 248 2145.5
targetglow @a[team=sgp.Canard] @a[gamemode=survival,team=sgp.Canard] GREEN
targetglow @a[team=sgp.Canard] @a[gamemode=survival,team=sgp.Oie] YELLOW
targetglow @a[team=sgp.Oie] @a[gamemode=survival,team=sgp.Oie] YELLOW
targetglow @a[team=sgp.Oie] @a[gamemode=survival,team=sgp.Poule] RED
targetglow @a[team=sgp.Poule] @a[gamemode=survival,team=sgp.Poule] RED
targetglow @a[team=sgp.Poule] @a[gamemode=survival,team=sgp.Canard] GREEN
execute as @a[team=sgp.Oie] run function sgp.majeurs:pco/oie/kit
execute as @a[team=sgp.Poule] run function sgp.majeurs:pco/poule/kit
execute as @a[team=sgp.Canard] run function sgp.majeurs:pco/canard/kit
move @a[team=sgp.Oie] #Oies
move @a[team=sgp.Poule] #Poules
move @a[team=sgp.Canard] #Canards
scoreboard players set @a[team=sgp.Oie] sgp.liberer_oies 0
scoreboard players set @a[team=sgp.Canard] sgp.liberer_canards 0
scoreboard players set @a[team=sgp.Poule] sgp.liberer_poules 0

title @a[team=sgp.Oie] subtitle [{"text":"Chassez les ","color":"white","bold":true},{"text":"Poules","color":"red"}]
title @a[team=sgp.Oie] title {"text":"Oie","color":"yellow","bold":true}
tellraw @a[team=sgp.Oie] [{"text":"Vous êtes une ","color":"white"},{"text":"Oie. ","color":"yellow","bold":true},{"text":"Vous devez chasser les ","color":"white"},{"text":"Poules.","color":"red","bold":true}]
title @a[team=sgp.Poule] subtitle [{"text":"Chassez les ","color":"white","bold":true},{"text":"Canards","color":"green"}]
title @a[team=sgp.Poule] title {"text":"Poule","color":"red","bold":true}
tellraw @a[team=sgp.Poule] [{"text":"Vous êtes une ","color":"white"},{"text":"Poule. ","color":"red","bold":true},{"text":"Vous devez chasser les ","color":"white"},{"text":"Canards.","color":"green","bold":true}]
title @a[team=sgp.Canard] subtitle [{"text":"Chassez les ","color":"white","bold":true},{"text":"Oies","color":"yellow"}]
title @a[team=sgp.Canard] title {"text":"Canard","color":"green","bold":true}
tellraw @a[team=sgp.Canard] [{"text":"Vous êtes un ","color":"white"},{"text":"Canard. ","color":"green","bold":true},{"text":"Vous devez chasser les ","color":"white"},{"text":"Oies.","color":"yellow","bold":true}]

fill 2500 239 2182 2500 239 2180 minecraft:warped_fence_gate[facing=west]
fill 2499 239 2179 2497 239 2179 minecraft:warped_fence_gate[facing=south]
fill 2538 248 2144 2540 248 2144 minecraft:warped_fence_gate[facing=north]
fill 2537 248 2141 2537 248 2143 minecraft:warped_fence_gate[facing=west]
fill 2524 248 2144 2526 248 2144 minecraft:warped_fence_gate[facing=north]
setblock 2478 244 2141 minecraft:warped_fence_gate[facing=west]
setblock 2484 244 2141 minecraft:warped_fence_gate[facing=west]

scoreboard players set @a[tag=in_game] sgp.temps_cabane_pco 0
function sgp.lore:npcs/disable