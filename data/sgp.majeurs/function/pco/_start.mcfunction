#> sgp.majeurs:pco/_start
#
# Start the PCO major event

tellraw @a[tag=sgp.in_game] [{"text":"Lancement de Poule Canard Oie...","color":"dark_purple","bold":true}]
function sgp.mineurs:_stop

statuswarp pvp disabled
useglow toggle
function sgp.majeurs:pco/dispatch

# Spawn the cages
execute as @e[type=marker,tag=sgp.marker,tag=sgp.enabled,name="pco_cage_storage"] \
    run function sgp.majeurs:pco/cage/compute_markers_coordinates

execute as @e[type=marker,tag=sgp.marker,tag=sgp.enabled,name="pco_cage_storage"] \
    run function sgp.majeurs:pco/cage/clone_cage with entity @s data


# Give the kit to the players, and apply glowing
execute as @a[team=sgp.Poule] \
    run function sgp.majeurs:pco/on_death {color:red, color_hex:16733525, color_material:redstone, cage:poule, team:Poule, to_catch:Canard, color_team:RED, color_to_catch:GREEN}

execute as @a[team=sgp.Canard] \
    run function sgp.majeurs:pco/on_death {color:green, color_hex:5635925, color_material:emerald, cage:canard, team:Canard, to_catch:Oie, color_team:GREEN, color_to_catch:YELLOW}

execute as @a[team=sgp.Oie] \
    run function sgp.majeurs:pco/on_death {color:yellow, color_hex:16777045, color_material:gold, cage:oie, team:Oie, to_catch:Poule, color_team:YELLOW, color_to_catch:RED}


# Teleport the players to their spawn
tp @a[team=sgp.Poule] @e[type=marker,tag=sgp.marker,tag=sgp.enabled,name="pco_poule_spawn",limit=1]
tp @a[team=sgp.Canard] @e[type=marker,tag=sgp.marker,tag=sgp.enabled,name="pco_canard_spawn",limit=1]
tp @a[team=sgp.Oie] @e[type=marker,tag=sgp.marker,tag=sgp.enabled,name="pco_oie_spawn",limit=1]


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


# Spawn the cabanes
execute as @e[type=marker,tag=sgp.marker,name="pco_cage_storage",tag=sgp.enabled,nbt={data:{cage:"poule"}},limit=1] \
    run function sgp.majeurs:pco/cabane/change_cabane_block {block:warped_fence_gate, block_to_replace:"#minecraft:air", block_2:green_concrete, block_to_replace_2:white_concrete, cage:"canard"}

execute as @e[type=marker,tag=sgp.marker,name="pco_cage_storage",tag=sgp.enabled,nbt={data:{cage:"oie"}},limit=1] \
    run function sgp.majeurs:pco/cabane/change_cabane_block {block:warped_fence_gate, block_to_replace:"#minecraft:air", block_2:green_concrete, block_to_replace_2:white_concrete, cage:"poule"}

execute as @e[type=marker,tag=sgp.marker,name="pco_cage_storage",tag=sgp.enabled,nbt={data:{cage:"canard"}},limit=1] \
    run function sgp.majeurs:pco/cabane/change_cabane_block {block:warped_fence_gate, block_to_replace:"#minecraft:air", block_2:green_concrete, block_to_replace_2:white_concrete, cage:"oie"}


scoreboard players set @a[tag=sgp.in_game] sgp.temps_cabane_pco 0

function sgp.lore:npcs/disable