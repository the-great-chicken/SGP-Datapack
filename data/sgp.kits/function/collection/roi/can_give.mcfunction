#> sgp.kits:collection/roi/can_give

execute if entity @a[tag=sgp.in_game,tag=sgp.roi_bleu] run tellraw @s [{storage:"sgp:text", nbt:"prefix", interpret:true}, {text:"Le kit Roi n'est pas disponible pour cet event.", color:dark_red}]
execute if entity @a[tag=sgp.in_game,tag=sgp.roi_bleu] run return 0

execute if entity @a[tag=sgp.in_game,tag=sgp.roi_rouge] run tellraw @s [{storage:"sgp:text", nbt:"prefix", interpret:true}, {text:"Le kit Roi n'est pas disponible pour cet event.", color:dark_red}]
execute if entity @a[tag=sgp.in_game,tag=sgp.roi_rouge] run return 0


return 1